import { useEffect, useState } from "react";
import { motion } from "motion/react";
import {
  Users,
  Calendar,
  DollarSign,
  CheckCircle2,
  Clock,
  XCircle,
  CalendarX,
} from "lucide-react";
import { useAuth } from "../../context/GlobalState";
import { BookingDetails, bookingsAPI } from "../../APIMethod/bookings";
import { roomsApi, CrowdingRoom } from "../../APIMethod/rooms";
import { ActionTypes } from "../../context/AppReducer";
import toast from "react-hot-toast";

export function Dashboard() {
  const { state, dispatch } = useAuth();
  const { bookingDetails } = state;
  const { BookingRevenues } = state;
  const [statusFilter, setStatusFilter] = useState("all");
  const [loading, setLoading] = useState(true);
  const [crowdingRooms, setCrowdingRooms] = useState<CrowdingRoom[]>([]);
  const [crowdingLoading, setCrowdingLoading] = useState(true);

  useEffect(() => {
    fetchBookingDetails();
    fetchBookingRevenues();
    fetchCrowding();
  }, []);

  const fetchBookingDetails = async () => {
    setLoading(true);
    try {
      const response = await bookingsAPI.getBookingDetails();
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

  const fetchBookingRevenues = async () => {
    setLoading(true);
    try {
      const response = await bookingsAPI.getBookingRevenues();
      dispatch({
        type: ActionTypes.SET_BOOKING_REVENUES,
        payload: response.data,
      });
    } catch (error) {
      console.error("فشل في جلب الايرادات:", error);
      toast.error("فشل في تحميل الايرادات");
    } finally {
      setLoading(false);
    }
  };

  const fetchCrowding = async () => {
    setCrowdingLoading(true);
    try {
      const response = await roomsApi.getCrowding();
      setCrowdingRooms(response.data);
    } catch (error) {
      console.error("فشل في جلب بيانات الإشغال:", error);
      toast.error("فشل في تحميل بيانات الإشغال");
    } finally {
      setCrowdingLoading(false);
    }
  };

  const roomsPerformance = crowdingRooms.map((room) => ({
    name: room.room_name,
    bookings: room.occupied_tables,
    occupancy: room.percentage,
  }));

  const getStatusBadge = (status: string) => {
    const badges = {
      completed: {
        text: "مؤكد",
        color: "bg-[#10B981]/10 text-[#10B981]",
        icon: CheckCircle2,
      },
      pending: {
        text: "معلق",
        color: "bg-[#F59E0B]/10 text-[#F59E0B]",
        icon: Clock,
      },
      cancelled: {
        text: "ملغي",
        color: "bg-[#EF4444]/10 text-[#EF4444]",
        icon: XCircle,
      },
    };

    return (
      badges[status as keyof typeof badges] ?? {
        text: status || "غير معروف",
        color: "bg-gray-100 text-gray-600",
        icon: Clock,
      }
    );
  };

  const getFilteredBookings = () => {
    if (statusFilter === "all") return bookingDetails;

    return bookingDetails.filter(
      (b: BookingDetails) => b.status === statusFilter,
    );
  };

  const filteredBookings = getFilteredBookings();
  const hasNoBookings = filteredBookings.length === 0;

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl text-gray-900 mb-2">لوحة التحكم الرئيسية</h1>
        <p className="text-gray-600">نظرة عامة على الأداء والإحصائيات</p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">إجمالي الحجوزات</p>
              <p className="text-2xl text-gray-900">{bookingDetails.length}</p>
            </div>
            <Calendar className="w-10 h-10 text-[#035177] opacity-20" />
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">المستخدمين النشطين</p>
              <p className="text-2xl text-gray-900">
                {BookingRevenues?.data?.bookings ?? 0}
              </p>
            </div>
            <Users className="w-10 h-10 text-[#ffb703] opacity-20" />
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-md p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600 mb-1">الإيرادات الشهرية</p>
              <p className="text-2xl text-gray-900">
                {BookingRevenues?.data?.revenue ?? 0}
              </p>
            </div>
            <DollarSign className="w-10 h-10 text-[#219ebc] opacity-20" />
          </div>
        </div>
      </div>

      {/* Recent Bookings Table */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.6 }}
        className="bg-white rounded-2xl shadow-md overflow-hidden"
      >
        <div className="p-6 border-b border-gray-200">
          <h2 className="text-xl text-gray-900">أحدث الحجوزات</h2>
        </div>
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
                  const StatusIcon = statusBadge.icon;
                  return (
                    <tr
                      key={booking.id_booking}
                      className="hover:bg-gray-50 transition-colors"
                    >
                      <td className="px-6 py-4 text-sm text-gray-900">
                        #{booking.id_booking}
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-900">
                        {booking.user.full_name}
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-700">
                        {new Date(booking.scheduled_start).toLocaleTimeString(
                          "ar-SA",
                        )}
                      </td>
                      <td className="px-6 py-4 text-sm text-[#2563EB]">
                        {booking.total_price} ر.س
                      </td>
                      <td className="px-6 py-4">
                        <span
                          className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs ${statusBadge.color}`}
                        >
                          <StatusIcon className="w-3.5 h-3.5" />
                          {statusBadge.text}
                        </span>
                      </td>
                    </tr>
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
            </motion.div>
          )}
        </div>
      </motion.div>

      {/* Top Performers Table */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.8 }}
        className="bg-white rounded-2xl shadow-md overflow-hidden"
      >
        <div className="p-6 border-b border-gray-200">
          <h2 className="text-xl text-gray-900">أفضل القاعات أداءً</h2>
        </div>
        <div className="overflow-x-auto">
          {crowdingLoading ? (
            <div className="flex items-center justify-center py-12 text-gray-400">
              جاري تحميل بيانات الإشغال...
            </div>
          ) : roomsPerformance.length === 0 ? (
            <div className="flex items-center justify-center py-12 text-gray-400">
              لا توجد بيانات متاحة
            </div>
          ) : (
            <table className="w-full">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-4 text-right text-sm text-gray-600">
                    القاعة
                  </th>
                  <th className="px-6 py-4 text-right text-sm text-gray-600">
                    عدد الحجوزات
                  </th>
                  <th className="px-6 py-4 text-right text-sm text-gray-600">
                    معدل الإشغال
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {roomsPerformance.map((room, index) => (
                  <tr
                    key={room.name}
                    className="hover:bg-gray-50 transition-colors"
                  >
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <span className="flex items-center justify-center w-8 h-8 bg-[#2563EB]/10 text-[#2563EB] rounded-lg text-sm">
                          #{index + 1}
                        </span>
                        <span className="text-sm text-gray-900">
                          {room.name}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {room.bookings}
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="flex-1 bg-gray-200 rounded-full h-2 max-w-[100px]">
                          <div
                            className="bg-[#10B981] h-2 rounded-full transition-all duration-500"
                            style={{ width: `${room.occupancy}%` }}
                          />
                        </div>
                        <span className="text-sm text-gray-700">
                          {room.occupancy}%
                        </span>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </motion.div>
    </div>
  );
}
