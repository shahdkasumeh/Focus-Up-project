import React, { useState } from "react";
import { motion } from "motion/react";
import {
  Search,
  Filter,
  Calendar,
  CheckCircle2,
  XCircle,
  Clock,
  Edit2,
  Eye,
  Download,
  RefreshCw,
} from "lucide-react";
import { Button } from "../../components/Button";

const bookings = [
  {
    id: 1001,
    user: "أحمد محمد",
    email: "ahmed@example.com",
    phone: "0501234567",
    room: "قاعة النجاح",
    center: "مركز التميز الدراسي",
    date: "2026-02-17",
    time: "14:00-18:00",
    seats: ["A1", "A3"],
    amount: 60,
    status: "confirmed",
    paymentMethod: "بطاقة ائتمانية",
    createdAt: "2026-02-15 10:30",
  },
  {
    id: 1002,
    user: "سارة أحمد",
    email: "sara@example.com",
    phone: "0509876543",
    room: "قاعة الإبداع",
    center: "مركز الطموح",
    date: "2026-02-17",
    time: "08:00-12:00",
    seats: ["B5"],
    amount: 80,
    status: "pending",
    paymentMethod: "محفظة إلكترونية",
    createdAt: "2026-02-16 14:20",
  },
  {
    id: 1003,
    user: "محمد علي",
    email: "mohammed@example.com",
    phone: "0555555555",
    room: "قاعة الهدوء",
    center: "مركز السكينة",
    date: "2026-02-18",
    time: "14:00-18:00",
    seats: ["C2", "C3"],
    amount: 48,
    status: "confirmed",
    paymentMethod: "بطاقة ائتمانية",
    createdAt: "2026-02-16 09:15",
  },
  {
    id: 1004,
    user: "فاطمة خالد",
    email: "fatima@example.com",
    phone: "0544444444",
    room: "قاعة التفوق",
    center: "مركز الإنجاز",
    date: "2026-02-18",
    time: "18:00-22:00",
    seats: ["A10"],
    amount: 72,
    status: "cancelled",
    paymentMethod: "بطاقة ائتمانية",
    createdAt: "2026-02-14 16:45",
  },
  {
    id: 1005,
    user: "خالد سعيد",
    email: "khalid@example.com",
    phone: "0533333333",
    room: "قاعة المعرفة",
    center: "مركز العلم",
    date: "2026-02-19",
    time: "14:00-18:00",
    seats: ["D1", "D2", "D3"],
    amount: 36,
    status: "confirmed",
    paymentMethod: "محفظة إلكترونية",
    createdAt: "2026-02-16 11:30",
  },
];

export function BookingsManagement() {
  const [searchQuery, setSearchQuery] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");
  const [selectedBooking, setSelectedBooking] = useState<any>(null);

  const getStatusBadge = (status: string) => {
    const badges = {
      confirmed: {
        text: "مؤكد",
        color: "bg-[#10B981]/10 text-[#10B981] border-[#10B981]/20",
        icon: CheckCircle2,
      },
      pending: {
        text: "معلق",
        color: "bg-[#F59E0B]/10 text-[#F59E0B] border-[#F59E0B]/20",
        icon: Clock,
      },
      cancelled: {
        text: "ملغي",
        color: "bg-[#EF4444]/10 text-[#EF4444] border-[#EF4444]/20",
        icon: XCircle,
      },
    };
    return badges[status as keyof typeof badges];
  };

  const filteredBookings =
    statusFilter === "all"
      ? bookings
      : bookings.filter((b) => b.status === statusFilter);

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة الحجوزات</h1>
          <p className="text-gray-600">عرض وإدارة جميع الحجوزات</p>
        </div>
        <div className="flex gap-3">
          <Button variant="outline">
            <Download className="w-5 h-5 ml-2" />
            تصدير Excel
          </Button>
          <Button variant="primary">
            <RefreshCw className="w-5 h-5 ml-2" />
            تحديث
          </Button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">إجمالي الحجوزات</p>
              <p className="text-2xl text-gray-900">{bookings.length}</p>
            </div>
            <Calendar className="w-10 h-10 text-[#2563EB] opacity-20" />
          </div>
        </div>
        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">مؤكدة</p>
              <p className="text-2xl text-[#10B981]">
                {bookings.filter((b) => b.status === "confirmed").length}
              </p>
            </div>
            <CheckCircle2 className="w-10 h-10 text-[#10B981] opacity-20" />
          </div>
        </div>
        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">معلقة</p>
              <p className="text-2xl text-[#F59E0B]">
                {bookings.filter((b) => b.status === "pending").length}
              </p>
            </div>
            <Clock className="w-10 h-10 text-[#F59E0B] opacity-20" />
          </div>
        </div>
        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">ملغاة</p>
              <p className="text-2xl text-[#EF4444]">
                {bookings.filter((b) => b.status === "cancelled").length}
              </p>
            </div>
            <XCircle className="w-10 h-10 text-[#EF4444] opacity-20" />
          </div>
        </div>
      </div>

      {/* Search & Filters */}
      <div className="bg-white rounded-2xl shadow-md p-6">
        <div className="flex gap-4">
          <div className="flex-1 relative">
            <Search className="absolute right-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="ابحث برقم الحجز أو اسم المستخدم..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-4 pr-11 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#2563EB]"
            />
          </div>
          <select
            className="px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#2563EB]"
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
          >
            <option value="all">جميع الحالات</option>
            <option value="confirmed">مؤكدة</option>
            <option value="pending">معلقة</option>
            <option value="cancelled">ملغاة</option>
          </select>
          <input
            type="date"
            className="px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#2563EB]"
          />
        </div>
      </div>

      {/* Bookings Table */}
      <div className="bg-white rounded-2xl shadow-md overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  رقم الحجز
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  المستخدم
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  القاعة
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  التاريخ
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  الوقت
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  المقاعد
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  المبلغ
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  الحالة
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  الإجراءات
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {filteredBookings.map((booking) => {
                const statusBadge = getStatusBadge(booking.status);
                const StatusIcon = statusBadge.icon;
                return (
                  <motion.tr
                    key={booking.id}
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    className="hover:bg-gray-50 transition-colors"
                  >
                    <td className="px-6 py-4">
                      <span className="text-sm text-[#2563EB]">
                        #{booking.id}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div>
                        <p className="text-sm text-gray-900">{booking.user}</p>
                        <p className="text-xs text-gray-500">{booking.email}</p>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div>
                        <p className="text-sm text-gray-900">{booking.room}</p>
                        <p className="text-xs text-gray-500">
                          {booking.center}
                        </p>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {booking.date}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {booking.time}
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex flex-wrap gap-1">
                        {booking.seats.map((seat) => (
                          <span
                            key={seat}
                            className="px-2 py-0.5 bg-blue-50 text-[#2563EB] rounded text-xs"
                          >
                            {seat}
                          </span>
                        ))}
                      </div>
                    </td>
                    <td className="px-6 py-4 text-sm text-[#2563EB]">
                      {booking.amount} ر.س
                    </td>
                    <td className="px-6 py-4">
                      <span
                        className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs border ${statusBadge.color}`}
                      >
                        <StatusIcon className="w-3.5 h-3.5" />
                        {statusBadge.text}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex gap-2">
                        <button
                          onClick={() => setSelectedBooking(booking)}
                          className="p-2 hover:bg-blue-50 rounded-lg text-[#2563EB] transition-colors"
                          title="عرض التفاصيل"
                        >
                          <Eye className="w-4 h-4" />
                        </button>
                        <button
                          className="p-2 hover:bg-gray-100 rounded-lg text-gray-600 transition-colors"
                          title="تعديل"
                        >
                          <Edit2 className="w-4 h-4" />
                        </button>
                      </div>
                    </td>
                  </motion.tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      {/* Booking Details Modal */}
      {selectedBooking && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-6"
          onClick={() => setSelectedBooking(null)}
        >
          <motion.div
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            onClick={(e) => e.stopPropagation()}
            className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto"
          >
            <div className="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
              <h2 className="text-2xl text-gray-900">
                تفاصيل الحجز #{selectedBooking.id}
              </h2>
              <button
                onClick={() => setSelectedBooking(null)}
                className="w-10 h-10 rounded-xl hover:bg-gray-100 flex items-center justify-center transition-colors"
              >
                ✕
              </button>
            </div>

            <div className="p-6 space-y-6">
              <div className="grid grid-cols-2 gap-6">
                <div>
                  <p className="text-sm text-gray-600 mb-1">المستخدم</p>
                  <p className="text-base text-gray-900">
                    {selectedBooking.user}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600 mb-1">
                    البريد الإلكتروني
                  </p>
                  <p className="text-base text-gray-900">
                    {selectedBooking.email}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600 mb-1">رقم الجوال</p>
                  <p className="text-base text-gray-900">
                    {selectedBooking.phone}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600 mb-1">القاعة</p>
                  <p className="text-base text-gray-900">
                    {selectedBooking.room}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600 mb-1">التاريخ</p>
                  <p className="text-base text-gray-900">
                    {selectedBooking.date}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600 mb-1">الوقت</p>
                  <p className="text-base text-gray-900">
                    {selectedBooking.time}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600 mb-1">طريقة الدفع</p>
                  <p className="text-base text-gray-900">
                    {selectedBooking.paymentMethod}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600 mb-1">المبلغ الإجمالي</p>
                  <p className="text-base text-[#2563EB]">
                    {selectedBooking.amount} ر.س
                  </p>
                </div>
              </div>

              <div className="flex gap-3">
                <Button variant="outline" className="flex-1">
                  تعديل الحجز
                </Button>
                <Button variant="danger" className="flex-1">
                  إلغاء الحجز
                </Button>
              </div>
            </div>
          </motion.div>
        </motion.div>
      )}
    </div>
  );
}
