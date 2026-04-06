import React, { useState } from "react";
import { motion } from "motion/react";
import {
  CalendarDays,
  Plus,
  Clock,
  MapPin,
  Users,
  Edit2,
  Trash2,
  Search,
  Filter,
  Calendar,
} from "lucide-react";

interface Event {
  id: string;
  title: string;
  date: string;
  time: string;
  room: string;
  capacity: number;
  registered: number;
  status: "upcoming" | "ongoing" | "completed";
}

export function EventsManagement() {
  const [searchTerm, setSearchTerm] = useState("");
  const [showAddModal, setShowAddModal] = useState(false);
  const [events, setEvents] = useState<Event[]>([
    {
      id: "1",
      title: "ورشة البرمجة",
      date: "2026-04-10",
      time: "14:00",
      room: "قاعة A",
      capacity: 30,
      registered: 25,
      status: "upcoming",
    },
    {
      id: "2",
      title: "محاضرة الذكاء الاصطناعي",
      date: "2026-04-08",
      time: "10:00",
      room: "قاعة B",
      capacity: 50,
      registered: 45,
      status: "upcoming",
    },
    {
      id: "3",
      title: "جلسة مراجعة الامتحانات",
      date: "2026-04-05",
      time: "16:00",
      room: "قاعة C",
      capacity: 20,
      registered: 18,
      status: "ongoing",
    },
  ]);

  const currentDate = new Date().toLocaleDateString("ar-SA", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  const currentTime = new Date().toLocaleTimeString("ar-SA", {
    hour: "2-digit",
    minute: "2-digit",
  });

  const getStatusColor = (status: string) => {
    switch (status) {
      case "upcoming":
        return "bg-blue-100 text-blue-700 border-blue-200";
      case "ongoing":
        return "bg-green-100 text-green-700 border-green-200";
      case "completed":
        return "bg-gray-100 text-gray-700 border-gray-200";
      default:
        return "bg-gray-100 text-gray-700 border-gray-200";
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case "upcoming":
        return "قادمة";
      case "ongoing":
        return "جارية";
      case "completed":
        return "منتهية";
      default:
        return status;
    }
  };

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة الفعاليات</h1>
          <div className="flex items-center gap-4 text-sm text-gray-600">
            <div className="flex items-center gap-2">
              <Calendar className="w-4 h-4 text-[#ffbf1f]" />
              <span>{currentDate}</span>
            </div>
            <div className="flex items-center gap-2">
              <Clock className="w-4 h-4 text-[#034363]" />
              <span>{currentTime}</span>
            </div>
          </div>
        </div>
        <button
          onClick={() => setShowAddModal(true)}
          className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] text-[#034363] rounded-xl hover:shadow-lg transition-all"
        >
          <Plus className="w-5 h-5" />
          إضافة فعالية
        </button>
      </div>

      {/* Search & Filter */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <div className="flex gap-4">
          <div className="flex-1 relative">
            <Search className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="البحث عن فعالية..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pr-12 pl-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none transition-colors"
            />
          </div>
          <button className="flex items-center gap-2 px-6 py-3 bg-gray-100 text-gray-700 rounded-xl hover:bg-gray-200 transition-colors">
            <Filter className="w-5 h-5" />
            تصفية
          </button>
        </div>
      </div>

      {/* Events Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {events.map((event, index) => (
          <motion.div
            key={event.id}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.1 }}
            className="bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-xl transition-shadow"
          >
            {/* Event Header */}
            <div className="bg-gradient-to-r from-[#034363] to-[#045a85] p-4">
              <div className="flex items-start justify-between mb-2">
                <h3 className="text-xl text-white">{event.title}</h3>
                <span
                  className={`px-3 py-1 rounded-lg text-xs border ${getStatusColor(
                    event.status,
                  )}`}
                >
                  {getStatusText(event.status)}
                </span>
              </div>
            </div>

            {/* Event Details */}
            <div className="p-4 space-y-3">
              <div className="flex items-center gap-3 text-gray-700">
                <Calendar className="w-5 h-5 text-[#ffbf1f]" />
                <span>{new Date(event.date).toLocaleDateString("ar-SA")}</span>
              </div>

              <div className="flex items-center gap-3 text-gray-700">
                <Clock className="w-5 h-5 text-[#ffbf1f]" />
                <span>{event.time}</span>
              </div>

              <div className="flex items-center gap-3 text-gray-700">
                <MapPin className="w-5 h-5 text-[#ffbf1f]" />
                <span>{event.room}</span>
              </div>

              <div className="flex items-center gap-3 text-gray-700">
                <Users className="w-5 h-5 text-[#ffbf1f]" />
                <span>
                  {event.registered} / {event.capacity} مسجل
                </span>
              </div>

              {/* Progress Bar */}
              <div className="pt-2">
                <div className="flex items-center justify-between text-sm text-gray-600 mb-2">
                  <span>نسبة الحضور</span>
                  <span>
                    {Math.round((event.registered / event.capacity) * 100)}%
                  </span>
                </div>
                <div className="h-2 bg-gray-200 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] transition-all"
                    style={{
                      width: `${(event.registered / event.capacity) * 100}%`,
                    }}
                  />
                </div>
              </div>
            </div>

            {/* Actions */}
            <div className="p-4 bg-gray-50 border-t border-gray-100 flex gap-2">
              <button className="flex-1 flex items-center justify-center gap-2 px-4 py-2 bg-[#034363] text-white rounded-xl hover:bg-[#045a85] transition-colors">
                <Edit2 className="w-4 h-4" />
                تعديل
              </button>
              <button className="flex items-center justify-center gap-2 px-4 py-2 bg-red-50 text-red-600 rounded-xl hover:bg-red-100 transition-colors">
                <Trash2 className="w-4 h-4" />
              </button>
            </div>
          </motion.div>
        ))}
      </div>

      {/* Add Event Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-6">
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full p-8"
          >
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-2xl text-gray-900">إضافة فعالية جديدة</h2>
              <button
                onClick={() => setShowAddModal(false)}
                className="w-10 h-10 bg-gray-100 hover:bg-gray-200 rounded-xl flex items-center justify-center transition-colors"
              >
                ✕
              </button>
            </div>

            <form className="space-y-4">
              <div>
                <label className="block text-sm text-gray-700 mb-2">
                  عنوان الفعالية
                </label>
                <input
                  type="text"
                  className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                  placeholder="مثال: ورشة البرمجة"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm text-gray-700 mb-2">
                    التاريخ
                  </label>
                  <input
                    type="date"
                    className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                  />
                </div>
                <div>
                  <label className="block text-sm text-gray-700 mb-2">
                    الوقت
                  </label>
                  <input
                    type="time"
                    className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm text-gray-700 mb-2">
                    القاعة
                  </label>
                  <select className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none">
                    <option>قاعة A</option>
                    <option>قاعة B</option>
                    <option>قاعة C</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm text-gray-700 mb-2">
                    السعة القصوى
                  </label>
                  <input
                    type="number"
                    className="w-full px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
                    placeholder="30"
                  />
                </div>
              </div>

              <div className="flex gap-3 pt-4">
                <button
                  type="button"
                  onClick={() => setShowAddModal(false)}
                  className="flex-1 px-6 py-3 bg-gray-100 text-gray-700 rounded-xl hover:bg-gray-200 transition-colors"
                >
                  إلغاء
                </button>
                <button
                  type="submit"
                  className="flex-1 px-6 py-3 bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] text-[#034363] rounded-xl hover:shadow-lg transition-all"
                >
                  إضافة الفعالية
                </button>
              </div>
            </form>
          </motion.div>
        </div>
      )}
    </div>
  );
}
