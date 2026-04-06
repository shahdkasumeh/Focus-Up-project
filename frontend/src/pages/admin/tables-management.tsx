import React, { useState } from "react";
import { motion } from "motion/react";
import {
  Building2,
  Grid3x3,
  Search,
  Filter,
  Users,
  Clock,
  Calendar,
  MapPin,
  Plus,
} from "lucide-react";

interface Table {
  id: string;
  number: number;
  isBooked: boolean;
  studentName?: string;
  bookingTime?: string;
  endTime?: string;
}

interface Room {
  id: string;
  name: string;
  capacity: number;
  tables: Table[];
}

export function TablesManagement() {
  const [selectedRoom, setSelectedRoom] = useState("1");
  const [searchTerm, setSearchTerm] = useState("");

  const [rooms, setRooms] = useState<Room[]>([
    {
      id: "1",
      name: "قاعة A",
      capacity: 30,
      tables: [
        {
          id: "1",
          number: 1,
          isBooked: true,
          studentName: "أحمد محمد",
          bookingTime: "09:00",
          endTime: "15:00",
        },
        { id: "2", number: 2, isBooked: false },
        {
          id: "3",
          number: 3,
          isBooked: true,
          studentName: "فاطمة علي",
          bookingTime: "10:00",
          endTime: "16:00",
        },
        { id: "4", number: 4, isBooked: false },
        {
          id: "5",
          number: 5,
          isBooked: true,
          studentName: "محمد سعيد",
          bookingTime: "08:00",
          endTime: "14:00",
        },
        { id: "6", number: 6, isBooked: false },
        { id: "7", number: 7, isBooked: false },
        {
          id: "8",
          number: 8,
          isBooked: true,
          studentName: "سارة حسن",
          bookingTime: "11:00",
          endTime: "17:00",
        },
        { id: "9", number: 9, isBooked: false },
        { id: "10", number: 10, isBooked: false },
        {
          id: "11",
          number: 11,
          isBooked: true,
          studentName: "عمر خالد",
          bookingTime: "09:30",
          endTime: "15:30",
        },
        { id: "12", number: 12, isBooked: false },
      ],
    },
    {
      id: "2",
      name: "قاعة B",
      capacity: 25,
      tables: [
        { id: "13", number: 1, isBooked: false },
        {
          id: "14",
          number: 2,
          isBooked: true,
          studentName: "نورا أحمد",
          bookingTime: "10:00",
          endTime: "16:00",
        },
        { id: "15", number: 3, isBooked: false },
        { id: "16", number: 4, isBooked: false },
        {
          id: "17",
          number: 5,
          isBooked: true,
          studentName: "يوسف عبدالله",
          bookingTime: "08:30",
          endTime: "14:30",
        },
        { id: "18", number: 6, isBooked: false },
        {
          id: "19",
          number: 7,
          isBooked: true,
          studentName: "ريم محمد",
          bookingTime: "09:00",
          endTime: "15:00",
        },
        { id: "20", number: 8, isBooked: false },
      ],
    },
    {
      id: "3",
      name: "قاعة C",
      capacity: 20,
      tables: [
        {
          id: "21",
          number: 1,
          isBooked: true,
          studentName: "خالد عمر",
          bookingTime: "08:00",
          endTime: "14:00",
        },
        { id: "22", number: 2, isBooked: false },
        { id: "23", number: 3, isBooked: false },
        {
          id: "24",
          number: 4,
          isBooked: true,
          studentName: "مريم سالم",
          bookingTime: "10:30",
          endTime: "16:30",
        },
        { id: "25", number: 5, isBooked: false },
        { id: "26", number: 6, isBooked: false },
      ],
    },
  ]);

  const currentRoom = rooms.find((room) => room.id === selectedRoom);
  const bookedTables =
    currentRoom?.tables.filter((t) => t.isBooked).length || 0;
  const availableTables = (currentRoom?.tables.length || 0) - bookedTables;

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
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
              <Building2 className="w-6 h-6 text-blue-600" />
            </div>
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">{rooms.length}</h3>
          <p className="text-gray-600 text-sm">إجمالي القاعات</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center">
              <Grid3x3 className="w-6 h-6 text-purple-600" />
            </div>
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {rooms.reduce((sum, room) => sum + room.tables.length, 0)}
          </h3>
          <p className="text-gray-600 text-sm">إجمالي الطاولات</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center">
              <Users className="w-6 h-6 text-red-600" />
            </div>
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {rooms.reduce(
              (sum, room) => sum + room.tables.filter((t) => t.isBooked).length,
              0,
            )}
          </h3>
          <p className="text-gray-600 text-sm">الطاولات المحجوزة</p>
        </div>

        <div className="bg-white rounded-2xl shadow-md p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center">
              <Grid3x3 className="w-6 h-6 text-green-600" />
            </div>
          </div>
          <h3 className="text-2xl text-gray-900 mb-1">
            {rooms.reduce(
              (sum, room) =>
                sum + room.tables.filter((t) => !t.isBooked).length,
              0,
            )}
          </h3>
          <p className="text-gray-600 text-sm">الطاولات المتاحة</p>
        </div>
      </div>

      {/* Room Selector */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <div className="flex items-center gap-4 mb-6">
          <Building2 className="w-6 h-6 text-[#ffbf1f]" />
          <h2 className="text-xl text-gray-900">اختر القاعة</h2>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {rooms.map((room) => {
            const roomBooked = room.tables.filter((t) => t.isBooked).length;
            const roomAvailable = room.tables.length - roomBooked;
            const occupancyPercentage = (roomBooked / room.tables.length) * 100;

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

      {/* Tables Grid */}
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
                    table.isBooked
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

                {/* Tooltip */}
                {table.isBooked && table.studentName && (
                  <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 hidden group-hover:block z-10">
                    <div className="bg-gray-900 text-white px-4 py-3 rounded-xl shadow-xl whitespace-nowrap text-sm">
                      <p className="mb-1">👤 {table.studentName}</p>
                      <p className="text-gray-300">
                        ⏰ {table.bookingTime} - {table.endTime}
                      </p>
                      <div className="absolute bottom-0 left-1/2 -translate-x-1/2 translate-y-1/2 rotate-45 w-2 h-2 bg-gray-900"></div>
                    </div>
                  </div>
                )}
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
    </div>
  );
}
