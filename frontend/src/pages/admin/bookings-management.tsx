import React, { useEffect, useState } from "react";
import { motion } from "motion/react";
import {
  Search,
  Filter,
  Calendar,
  CheckCircle2,
  XCircle,
  Clock,
  CalendarX,
} from "lucide-react";
import { useAuth } from "../../context/GlobalState";
import { ActionTypes } from "../../context/AppReducer";
import toast from "react-hot-toast";

import { BookingDetails, bookingsAPI } from "../../APIMethod/bookings";

export function BookingsManagement() {
  const { state, dispatch } = useAuth();

  const { bookingDetails } = state;
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");

  useEffect(() => {
    fetchBookingDetails();
  }, []);

  const fetchBookingDetails = async () => {
    setLoading(true);
    try {
      const response = await bookingsAPI.getBookingDetails();
      console.log("الحجوزات المستلمة:", response.data);
      dispatch({
        type: ActionTypes.SET_BOOKINGDETAILS,
        payload: response.data,
      });
    } catch (error) {
      console.error("فشل في جلب الحجوزات:", error);
      toast.error("فشل في تحميل الحجوزات");
    } finally {
      setLoading(false);
    }
  };

  const getStatusBadge = (status: string) => {
    const badges = {
      pending: {
        text: "معلق",
        color: "bg-[#F59E0B]/10 text-[#F59E0B] border-[#F59E0B]/20",
        icon: Clock,
      },
      confirmed: {
        text: "مؤكد",
        color: "bg-[#10B981]/10 text-[#10B981] border-[#10B981]/20",
        icon: CheckCircle2,
      },
      active: {
        text: "نشط",
        color: "bg-[#3B82F6]/10 text-[#3B82F6] border-[#3B82F6]/20",
        icon: CheckCircle2,
      },
      completed: {
        text: "مكتمل",
        color: "bg-[#10B981]/10 text-[#10B981] border-[#10B981]/20",
        icon: CheckCircle2,
      },
      cancelled: {
        text: "ملغي",
        color: "bg-[#EF4444]/10 text-[#EF4444] border-[#EF4444]/20",
        icon: XCircle,
      },
    };

    // إذا كانت الحالة غير معرفة، نعرض حالة افتراضية
    const defaultBadge = {
      text: status || "غير معروف",
      color: "bg-gray-100 text-gray-600 border-gray-200",
      icon: Clock,
    };

    return badges[status as keyof typeof badges] || defaultBadge;
  };

  const getFilteredBookings = () => {
    let filtered =
      statusFilter === "all"
        ? bookingDetails
        : bookingDetails.filter(
            (b: BookingDetails) => b.status === statusFilter,
          );

    if (searchQuery) {
      filtered = filtered.filter(
        (booking) =>
          booking.id_booking ||
          booking.user.full_name
            .toLowerCase()
            .includes(searchQuery.toLowerCase()),
      );
    }

    return filtered;
  };

  const filteredBookings = getFilteredBookings();

  const hasNoBookings = filteredBookings.length === 0;

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">إدارة الحجوزات</h1>
          <p className="text-gray-600">عرض وإدارة جميع الحجوزات</p>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">إجمالي الحجوزات</p>
              <p className="text-2xl text-gray-900">{bookingDetails.length}</p>
            </div>
            <Calendar className="w-10 h-10 text-[#2563EB] opacity-20" />
          </div>
        </div>
        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">مؤكدة</p>
              <p className="text-2xl text-[#10B981]">
                {
                  bookingDetails.filter((b) => b.status === "active").length
                }{" "}
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
                {bookingDetails.filter((b) => b.status === "pending").length}
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
                {bookingDetails.filter((b) => b.status === "cancelled").length}
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
          {!hasNoBookings ? (
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
                    التاريخ & الوقت
                  </th>
                  <th className="px-6 py-4 text-right text-sm text-gray-600">
                    المكان
                  </th>
                  <th className="px-6 py-4 text-right text-sm text-gray-600">
                    المبلغ
                  </th>
                  <th className="px-6 py-4 text-right text-sm text-gray-600">
                    الحالة
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {filteredBookings.map((booking) => {
                  const statusBadge = getStatusBadge(booking.status);
                  if (!statusBadge) {
                    return null;
                  }

                  const StatusIcon = statusBadge.icon;

                  return (
                    <motion.tr
                      key={booking.id_booking}
                      initial={{ opacity: 0 }}
                      animate={{ opacity: 1 }}
                      className="hover:bg-gray-50 transition-colors"
                    >
                      <td className="px-6 py-4">
                        <span className="text-sm text-[#2563EB] font-medium">
                          #{booking.id_booking}{" "}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <div>
                          <p className="text-sm text-gray-900 font-medium">
                            {booking.user.full_name}
                          </p>
                          <p className="text-xs text-gray-500">
                            ID: {booking.user.id}
                          </p>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <div className="text-sm text-gray-700">
                          <p>
                            {new Date(
                              booking.scheduled_start,
                            ).toLocaleDateString("ar-SA")}
                          </p>
                          <p className="text-xs text-gray-500">
                            {new Date(
                              booking.scheduled_start,
                            ).toLocaleTimeString("ar-SA")}
                          </p>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex flex-wrap gap-1">
                          <span
                            key={booking.place.id}
                            className="px-2 py-0.5 bg-blue-50 text-[#2563EB] rounded text-xs"
                          >
                            {booking.place.name}
                          </span>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm font-semibold text-[#2563EB]">
                          {booking.total_price} ر.س
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <span
                          className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs font-medium border ${statusBadge.color}`}
                        >
                          <StatusIcon className="w-3.5 h-3.5" />
                          {statusBadge.text}
                        </span>
                      </td>
                    </motion.tr>
                  );
                })}
              </tbody>
            </table>
          ) : (
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              className="flex flex-col items-center justify-center py-16 px-4"
            >
              <div className="bg-gray-50 rounded-full p-6 mb-4">
                <CalendarX className="w-16 h-16 text-gray-400" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-2">
                لا توجد حجوزات
              </h3>
              <p className="text-gray-500 text-center max-w-md">
                {searchQuery || statusFilter !== "all"
                  ? "لا توجد نتائج تطابق معايير البحث الحالية. حاول تغيير الفلتر أو البحث."
                  : "لم يتم العثور على أي حجوزات بعد. ستبدو الحجوزات هنا عند إنشائها."}
              </p>
              {(searchQuery || statusFilter !== "all") && (
                <button
                  onClick={() => {
                    setSearchQuery("");
                    setStatusFilter("all");
                  }}
                  className="mt-4 px-4 py-2 text-sm bg-[#2563EB] text-white rounded-lg hover:bg-[#1D4ED8] transition-colors"
                >
                  مسح جميع الفلاتر
                </button>
              )}
            </motion.div>
          )}
        </div>
      </div>
    </div>
  );
}
