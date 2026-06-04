import React, { useState, useEffect, useMemo, useCallback } from "react";
import { motion, AnimatePresence } from "motion/react";
import {
  ArrowRight,
  Table,
  Building2,
  ChevronLeft,
  Loader2,
  AlertCircle,
} from "lucide-react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../../context/GlobalState";
import { ActionTypes } from "../../context/AppReducer";
import { Tables, tablesApi } from "../../APIMethod/tables";
import { roomsApi } from "../../APIMethod/rooms";
import toast from "react-hot-toast";

export function ReceptionTablesManagement() {
  const navigate = useNavigate();
  const { state, dispatch } = useAuth();
  const [selectedRoomId, setSelectedRoomId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadingTables, setLoadingTables] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [roomsList, setRoomsList] = useState<any[]>([]);

  useEffect(() => {
    const fetchRooms = async () => {
      try {
        setLoading(true);
        setError(null);
        const roomsResponse = await roomsApi.getRooms();
        console.log("تم جلب القاعات:", roomsResponse.data);
        setRoomsList(roomsResponse.data);
        dispatch({
          type: ActionTypes.SET_ROOMS,
          payload: roomsResponse.data,
        });
      } catch (error) {
        console.error("Error fetching rooms:", error);
        if (error === 403) {
          setError("ليس لديك صلاحية لعرض القاعات. يرجى التواصل مع المدير.");
        } else {
          setError("فشل في تحميل القاعات. يرجى المحاولة مرة أخرى.");
        }
      } finally {
        setLoading(false);
      }
    };

    fetchRooms();
  }, [dispatch]);

  const fetchTablesForRoom = useCallback(
    async (roomId: number) => {
      try {
        setLoadingTables(true);
        console.log(`جلب طاولات القاعة ${roomId}...`);
        const tablesResponse = await tablesApi.getAllTables();
        const roomTables = tablesResponse.data.filter(
          (table: any) => table.room_id === roomId,
        );
        console.log(`تم جلب ${roomTables.length} طاولة للقاعة ${roomId}`);
        const existingTables = state.tables || [];
        const allTables = [...existingTables, ...tablesResponse.data];
        const uniqueTables = Array.from(
          new Map(allTables.map((table) => [table.id, table])).values(),
        );

        dispatch({
          type: ActionTypes.SET_TABLES,
          payload: uniqueTables,
        });
      } catch (err) {
        console.error("Error fetching tables:", err);
        toast.error("فشل في تحميل الطاولات لهذه القاعة");
        if (err === 403) {
          toast.error("ليس لديك صلاحية لعرض الطاولات");
        }
      } finally {
        setLoadingTables(false);
      }
    },
    [dispatch, state.tables],
  );

  const handleRoomSelect = useCallback(
    async (roomId: number) => {
      setSelectedRoomId(roomId);
      const hasTablesForRoom = state.tables?.some(
        (table) => table.room_id === roomId,
      );
      if (!hasTablesForRoom) {
        await fetchTablesForRoom(roomId);
      }
    },
    [state.tables, fetchTablesForRoom],
  );

  const roomsWithTables = useMemo(() => {
    if (!roomsList.length) return [];

    return roomsList.map((room) => {
      const roomTables = (state.tables || []).filter(
        (table) => table.room_id === room.id,
      );

      return {
        ...room,
        tables: roomTables,
        stats: {
          total: roomTables.length,
          booked: roomTables.filter((table) => table.is_occupied === 1).length,
          available: roomTables.filter(
            (table) => table.is_active === 1 && table.is_occupied === 0,
          ).length,
        },
        hasTablesLoaded: roomTables.length > 0,
      };
    });
  }, [roomsList, state.tables]);

  const currentRoom = roomsWithTables.find(
    (room) => room.id === selectedRoomId,
  );
  const currentRoomTables = currentRoom?.tables || [];

  const roomStats = useMemo(() => {
    if (!currentRoom) return { total: 0, booked: 0, available: 0 };
    return currentRoom.stats;
  }, [currentRoom]);

  const handleBack = useCallback(() => {
    if (selectedRoomId) {
      setSelectedRoomId(null);
    } else {
      navigate(-1);
    }
  }, [selectedRoomId, navigate]);

  if (loading) {
    return (
      <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50 flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="w-12 h-12 text-[#034363] animate-spin mx-auto mb-4" />
          <p className="text-gray-600">جاري تحميل القاعات...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50 flex items-center justify-center">
        <div className="text-center bg-white rounded-2xl p-8 max-w-md">
          <AlertCircle className="w-16 h-16 text-red-500 mx-auto mb-4" />
          <p className="text-gray-800 text-lg mb-4">{error}</p>
          <button
            onClick={() => window.location.reload()}
            className="px-6 py-2 bg-[#034363] text-white rounded-xl hover:bg-[#045a85] transition-colors"
          >
            إعادة المحاولة
          </button>
        </div>
      </div>
    );
  }

  if (roomsList.length === 0) {
    return (
      <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50 flex items-center justify-center">
        <div className="text-center bg-white rounded-2xl p-12 max-w-md">
          <Building2 className="w-20 h-20 text-gray-400 mx-auto mb-4" />
          <h3 className="text-2xl text-gray-900 mb-2">لا توجد قاعات</h3>
          <p className="text-gray-600">لم يتم إضافة أي قاعات بعد</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50">
      {/* Header */}
      <div className="bg-linear-to-r from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-7xl mx-auto">
          <div className="flex items-center gap-4">
            <button
              onClick={handleBack}
              className="p-2 hover:bg-white/10 rounded-xl transition-colors"
            >
              <ArrowRight className="w-6 h-6" />
            </button>
            <div>
              <h1 className="text-3xl font-bold mb-1">
                {currentRoom ? currentRoom.name : "إدارة الطاولات"}
              </h1>
              <p className="text-blue-100">
                {currentRoom
                  ? `عرض طاولات ${currentRoom.name} - ${roomStats.available} طاولات متاحة من ${roomStats.total}`
                  : "اختر القاعة لعرض الطاولات"}
              </p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto p-6">
        <AnimatePresence mode="wait">
          {!selectedRoomId ? (
            <motion.div
              key="rooms"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -20 }}
              className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
            >
              {roomsWithTables.map((room, index) => (
                <motion.div
                  key={room.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.1 }}
                  onClick={() => handleRoomSelect(room.id)}
                  className="cursor-pointer group"
                >
                  <div className="bg-white rounded-2xl p-6 shadow-md hover:shadow-2xl transition-all duration-300 border-2 border-transparent hover:border-[#ffbf1f]">
                    <div className="flex items-center justify-between mb-4">
                      <div className="w-14 h-14 bg-linear-to-br from-[#034363] to-[#045a85] rounded-2xl flex items-center justify-center text-white text-2xl shadow-lg group-hover:scale-110 transition-transform">
                        <Building2 className="w-7 h-7" />
                      </div>
                      <ChevronLeft className="w-6 h-6 text-gray-400 group-hover:text-[#ffbf1f] transition-colors" />
                    </div>

                    <h3 className="text-2xl font-bold text-gray-900 mb-3">
                      {room.name}
                    </h3>

                    <div className="space-y-2">
                      <div className="flex items-center justify-between p-3 bg-gray-50 rounded-xl">
                        <span className="text-gray-600">سعة القاعة</span>
                        <span className="text-xl font-bold text-gray-900">
                          {room.capacity}
                        </span>
                      </div>

                      <div className="flex items-center justify-between p-3 bg-gray-50 rounded-xl">
                        <span className="text-gray-600">عدد الطاولات</span>
                        <div className="flex gap-2">
                          {room.hasTablesLoaded ? (
                            <>
                              <span className="px-2 py-1 bg-green-100 text-green-700 rounded-lg text-sm">
                                متاحة: {room.stats.available}
                              </span>
                              <span className="px-2 py-1 bg-yellow-100 text-yellow-700 rounded-lg text-sm">
                                محجوزة: {room.stats.booked}
                              </span>
                              <span className="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">
                                إجمالي: {room.stats.total}
                              </span>
                            </>
                          ) : (
                            <span className="px-2 py-1 bg-gray-100 text-gray-500 rounded-lg text-sm">
                              لم يتم تحميل بعد
                            </span>
                          )}
                        </div>
                      </div>
                    </div>
                  </div>
                </motion.div>
              ))}
            </motion.div>
          ) : (
            <motion.div
              key="tables"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -20 }}
            >
              {loadingTables ? (
                <div className="bg-white rounded-2xl p-12 text-center">
                  <Loader2 className="w-12 h-12 text-[#034363] animate-spin mx-auto mb-4" />
                  <p className="text-gray-600">جاري تحميل الطاولات...</p>
                </div>
              ) : currentRoomTables.length === 0 ? (
                <div className="bg-white rounded-2xl p-12 text-center">
                  <Table className="w-16 h-16 text-gray-400 mx-auto mb-4" />
                  <h3 className="text-xl text-gray-900 mb-2">لا توجد طاولات</h3>
                  <p className="text-gray-600">
                    لم يتم إضافة أي طاولات لهذه القاعة بعد
                  </p>
                </div>
              ) : (
                <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
                  {currentRoomTables.map((table: Tables, index: number) => (
                    <motion.div
                      key={table.id}
                      initial={{ opacity: 0, scale: 0.9 }}
                      animate={{ opacity: 1, scale: 1 }}
                      transition={{ delay: index * 0.05 }}
                      className="cursor-pointer group"
                    >
                      <div
                        className={`rounded-2xl p-6 shadow-md hover:shadow-xl transition-all duration-300 border-2 ${
                          table.is_occupied === 1
                            ? "bg-[#ffbf1f] border-[#e6ac1c]"
                            : !table.is_active
                              ? "bg-gray-100 border-gray-200 opacity-60"
                              : "bg-white border-gray-200 hover:border-[#10B981]"
                        }`}
                      >
                        <div className="flex flex-col items-center justify-center space-y-3">
                          <div
                            className={`w-16 h-16 rounded-xl flex items-center justify-center transition-all ${
                              table.is_occupied === 1
                                ? "bg-white/20 text-white"
                                : !table.is_active
                                  ? "bg-gray-300 text-gray-500"
                                  : "bg-gray-100 text-gray-700 group-hover:bg-green-100 group-hover:text-green-600"
                            }`}
                          >
                            <Table className="w-8 h-8" />
                          </div>

                          <h3
                            className={`text-xl font-bold ${
                              table.is_occupied === 1
                                ? "text-white"
                                : !table.is_active
                                  ? "text-gray-500"
                                  : "text-gray-900"
                            }`}
                          >
                            طاولة {table.table_num}
                          </h3>

                          <div
                            className={`px-4 py-2 rounded-lg text-sm font-medium ${
                              table.is_occupied === 1
                                ? "bg-white/20 text-white"
                                : !table.is_active
                                  ? "bg-gray-200 text-gray-500"
                                  : "bg-green-50 text-green-700"
                            }`}
                          >
                            {table.is_occupied === 1
                              ? "محجوزة"
                              : !table.is_active
                                ? "غير نشطة"
                                : "متاحة"}
                          </div>
                        </div>
                      </div>
                    </motion.div>
                  ))}
                </div>
              )}
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
}
