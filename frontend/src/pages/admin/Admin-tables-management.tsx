import React, { useEffect, useState, useMemo } from "react";
import { motion } from "motion/react";
import { ActionTypes } from "../../context/AppReducer";
import { Building2, Grid3x3, Plus, Users } from "lucide-react";
import { useAuth } from "../../context/GlobalState";
import { Button } from "../../components/Button";
import { AddTable } from "./components/AddTable";
import toast from "react-hot-toast";
import { Table, tablesApi } from "../../APIMethod/tables";

export function AdminTablesManagement() {
  const { state, dispatch } = useAuth();
  const { tables } = state;
  const [selectedRoom, setSelectedRoom] = useState<string>("");
  const [showAddTableModal, setShowAddTableModal] = useState(false);

  useEffect(() => {
    async function fetchTables() {
      if (state.tables.length > 0) return;
      try {
        const response = await tablesApi.getAllTables();
        dispatch({ type: ActionTypes.SET_TABLES, payload: response.data });
      } catch (error) {
        console.log("خطأ", error);
      }
    }
    fetchTables();
  }, []);

  // دمج القاعات والطاولات
  const roomsWithTables = useMemo(() => {
    if (!state.rooms || !state.tables) return [];

    return state.rooms.map((room) => ({
      id: room.id.toString(),
      name: room.name,
      capacity: room.capacity,
      tables: state.tables
        .filter((table) => table.room_id === room.id)
        .map((table) => ({
          id: table.id.toString(),
          number: table.table_num,
          isBooked: table.is_occupied === 1,
          is_active: table.is_active,
          is_occupied: table.is_occupied,
        })),
    }));
  }, [state.rooms, state.tables]);

  // تحديد أول قاعة
  useEffect(() => {
    if (roomsWithTables.length > 0 && !selectedRoom) {
      setSelectedRoom(roomsWithTables[0].id);
    }
  }, [roomsWithTables, selectedRoom]);

  // فحص عدم وجود قاعات
  if (roomsWithTables.length === 0) {
    return (
      <div className="p-6">
        <div className="bg-yellow-50 border border-yellow-200 rounded-2xl p-12 text-center">
          <Building2 className="w-16 h-16 text-yellow-600 mx-auto mb-4" />
          <h3 className="text-xl text-gray-900 mb-2">لا توجد قاعات</h3>
          <p className="text-gray-600">لم يتم إضافة أي قاعات بعد</p>
        </div>
      </div>
    );
  }

  const currentRoom = roomsWithTables.find((room) => room.id === selectedRoom);
  const bookedTables =
    currentRoom?.tables.filter((t) => t.isBooked).length || 0;
  const availableTables = (currentRoom?.tables.length || 0) - bookedTables;

  const handleTableAdded = (newTable: Table) => {
    dispatch({ type: ActionTypes.ADD_TABLE, payload: newTable });
    setShowAddTableModal(false);
    toast.success("تمت إضافة الطاولة بنجاح");
  };

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة الطاولات</h1>
          <p className="text-gray-600">
            عرض وإدارة حالة الطاولات في جميع القاعات
          </p>
        </div>
        <Button variant="primary" onClick={() => setShowAddTableModal(true)}>
          <Plus className="w-5 h-5 ml-2" />
          إضافة طاولة جديدة
        </Button>
      </div>

      {/* Stats - استخدم roomsWithTables */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4">
            <Building2 className="w-6 h-6 text-blue-600" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {roomsWithTables.length}
          </h3>
          <p className="text-gray-600 text-sm">إجمالي القاعات</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center mb-4">
            <Grid3x3 className="w-6 h-6 text-purple-600" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {roomsWithTables.reduce((sum, room) => sum + room.tables.length, 0)}
          </h3>
          <p className="text-gray-600 text-sm">إجمالي الطاولات</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center mb-4">
            <Users className="w-6 h-6 text-red-600" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {roomsWithTables.reduce(
              (sum, room) => sum + room.tables.filter((t) => t.isBooked).length,
              0,
            )}
          </h3>
          <p className="text-gray-600 text-sm">الطاولات المحجوزة</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center mb-4">
            <Grid3x3 className="w-6 h-6 text-green-600" />
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {roomsWithTables.reduce(
              (sum, room) =>
                sum + room.tables.filter((t) => !t.isBooked).length,
              0,
            )}
          </h3>
          <p className="text-gray-600 text-sm">الطاولات المتاحة</p>
        </div>
      </div>

      {/* Room Selector - بطاقات القاعات */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <div className="flex items-center gap-4 mb-6">
          <Building2 className="w-6 h-6 text-[#ffbf1f]" />
          <h2 className="text-xl text-gray-900">اختر القاعة</h2>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {roomsWithTables.map((room) => {
            const roomBooked = room.tables.filter((t) => t.isBooked).length;
            const roomAvailable = room.tables.length - roomBooked;
            const occupancyPercentage =
              room.tables.length === 0
                ? 0
                : (roomBooked / room.tables.length) * 100;

            return (
              <button
                key={room.id}
                onClick={() => setSelectedRoom(room.id)}
                className={`p-4 rounded-xl border-2 transition-all text-right ${
                  selectedRoom === room.id
                    ? "border-[#ffbf1f] bg-[#ffbf1f]/10"
                    : "border-gray-200 hover:border-gray-300"
                }`}
              >
                <div className="flex items-center justify-between mb-3">
                  <h3 className="text-lg text-gray-900">{room.name}</h3>
                  <div className="w-10 h-10 bg-gradient-to-br from-[#034363] to-[#045a85] rounded-xl flex items-center justify-center">
                    <Building2 className="w-5 h-5 text-white" />
                  </div>
                </div>
                <div className="space-y-2 text-sm text-gray-600">
                  <div className="flex items-center justify-between">
                    <span>المحجوز</span>
                    <span className="text-red-600">{roomBooked}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <span>المتاح</span>
                    <span className="text-green-600">{roomAvailable}</span>
                  </div>
                  <div className="h-2 bg-gray-200 rounded-full overflow-hidden mt-2">
                    <div
                      className="h-full bg-gradient-to-r from-red-500 to-red-600"
                      style={{ width: `${occupancyPercentage}%` }}
                    />
                  </div>
                </div>
              </button>
            );
          })}
        </div>
      </div>

      {/* Tables Grid - طاولات القاعة المختارة */}
      {currentRoom && (
        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 className="text-xl text-gray-900 mb-2">{currentRoom.name}</h2>
              <div className="flex items-center gap-6 text-sm text-gray-600">
                <div className="flex items-center gap-2">
                  <div className="w-4 h-4 bg-red-500 rounded"></div>
                  <span>محجوز ({bookedTables})</span>
                </div>
                <div className="flex items-center gap-2">
                  <div className="w-4 h-4 bg-gray-300 rounded"></div>
                  <span>متاح ({availableTables})</span>
                </div>
              </div>
            </div>
          </div>

          <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
            {currentRoom.tables.map((table, index) => (
              <motion.div
                key={table.id}
                initial={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: index * 0.05 }}
                className="relative group"
              >
                <div
                  className={`aspect-square rounded-2xl p-4 flex flex-col items-center justify-center cursor-pointer transition-all ${
                    table.is_active === 1 && table.is_occupied === 1
                      ? "bg-gradient-to-br from-red-500 to-red-600 hover:shadow-xl"
                      : "bg-gray-300 hover:bg-gray-400 hover:shadow-lg"
                  }`}
                >
                  <div className="text-center">
                    <div
                      className={`w-12 h-12 rounded-xl flex items-center justify-center mb-2 ${
                        table.isBooked ? "bg-white/20" : "bg-white/50"
                      }`}
                    >
                      <Grid3x3
                        className={`w-6 h-6 ${table.isBooked ? "text-white" : "text-gray-600"}`}
                      />
                    </div>
                    <p
                      className={`text-lg ${table.isBooked ? "text-white" : "text-gray-700"}`}
                    >
                      {table.number}
                    </p>
                    <p
                      className={`text-xs ${table.isBooked ? "text-white/80" : "text-gray-600"}`}
                    >
                      {table.isBooked ? "محجوز" : "متاح"}
                    </p>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      )}

      {/* Legend */}
      <div className="bg-gradient-to-r from-[#034363] to-[#045a85] rounded-2xl shadow-md p-6 text-white">
        <h3 className="text-lg mb-4">إرشادات الاستخدام</h3>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
          <div className="flex items-start gap-3">
            <div className="w-8 h-8 bg-red-500 rounded-lg shrink-0"></div>
            <div>
              <p className="mb-1">الطاولات المحجوزة</p>
              <p className="text-white/70 text-xs">
                مرر الماوس لعرض تفاصيل الحجز
              </p>
            </div>
          </div>
          <div className="flex items-start gap-3">
            <div className="w-8 h-8 bg-gray-300 rounded-lg shrink-0"></div>
            <div>
              <p className="mb-1">الطاولات المتاحة</p>
              <p className="text-white/70 text-xs">جاهزة للحجز من قبل الطلاب</p>
            </div>
          </div>
        </div>
      </div>
      {showAddTableModal && (
        <AddTable
          onClose={() => setShowAddTableModal(false)}
          onSuccess={handleTableAdded}
        />
      )}
    </div>
  );
}
