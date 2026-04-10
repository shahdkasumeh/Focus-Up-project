import React from "react";
import { motion } from "motion/react";
import {
  TrendingUp,
  Users,
  Calendar,
  DollarSign,
  Building2,
  CheckCircle2,
  Clock,
  XCircle,
} from "lucide-react";
import {
  LineChart,
  Line,
  BarChart,
  Bar,
  PieChart,
  Pie,
  Cell,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";

const stats = [
  {
    label: "إجمالي الحجوزات",
    value: "1,284",
    change: "+12.5%",
    trend: "up",
    icon: Calendar,
    color: "from-[#035177] to-[#035177]",
  },
  {
    label: "المستخدمين النشطين",
    value: "856",
    change: "+8.2%",
    trend: "up",
    icon: Users,
    color: "from-[#ffb703] to-[#ffb703]",
  },
  {
    label: "الإيرادات الشهرية",
    value: "45,280 ر.س",
    change: "+15.3%",
    trend: "up",
    icon: DollarSign,
    color: "from-[#219ebc] to-[#219ebc]",
  },
  {
    label: "معدل الإشغال",
    value: "78%",
    change: "+5.1%",
    trend: "up",
    icon: TrendingUp,
    color: "from-[#fb8500] to-[#fb8500]",
  },
];

const revenueData = [
  { month: "يناير", revenue: 28000, bookings: 245 },
  { month: "فبراير", revenue: 32000, bookings: 298 },
  { month: "مارس", revenue: 35000, bookings: 320 },
  { month: "أبريل", revenue: 38000, bookings: 356 },
  { month: "مايو", revenue: 42000, bookings: 389 },
  { month: "يونيو", revenue: 45280, bookings: 412 },
];

const roomsData = [
  { name: "قاعة النجاح", bookings: 145, fill: "#8ecae6" },
  { name: "قاعة الإبداع", bookings: 98, fill: "#219ebc" },
  { name: "قاعة الهدوء", bookings: 167, fill: "#ffb703" },
  { name: "قاعة التفوق", bookings: 112, fill: "#023047" },
  { name: "قاعة المعرفة", bookings: 201, fill: "#fb8500" },
];

const recentBookings = [
  {
    id: 1,
    user: "أحمد محمد",
    room: "قاعة النجاح",
    date: "2026-02-17",
    time: "14:00-18:00",
    status: "confirmed",
    amount: 60,
  },
  {
    id: 2,
    user: "سارة أحمد",
    room: "قاعة الإبداع",
    date: "2026-02-17",
    time: "08:00-12:00",
    status: "pending",
    amount: 80,
  },
  {
    id: 3,
    user: "محمد علي",
    room: "قاعة الهدوء",
    date: "2026-02-18",
    time: "14:00-18:00",
    status: "confirmed",
    amount: 48,
  },
  {
    id: 4,
    user: "فاطمة خالد",
    room: "قاعة التفوق",
    date: "2026-02-18",
    time: "18:00-22:00",
    status: "cancelled",
    amount: 72,
  },
];

//دالة لتحديد حالة الحجز
const getStatusBadge = (status: string) => {
  const badges = {
    confirmed: {
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
  return badges[status as keyof typeof badges];
};

export function Dashboard() {
  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl text-gray-900 mb-2">لوحة التحكم الرئيسية</h1>
        <p className="text-gray-600">نظرة عامة على الأداء والإحصائيات</p>
      </div>
      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {stats.map((stat, index) => {
          const Icon = stat.icon;
          return (
            <motion.div
              key={stat.label}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              className="bg-white rounded-2xl shadow-md p-6 hover:shadow-lg transition-shadow"
            >
              <div className="flex items-start justify-between mb-4">
                <div
                  className={`w-12 h-12 rounded-xl bg-gradient-to-br ${stat.color} flex items-center justify-center`}
                >
                  <Icon className="w-6 h-6 text-white" />
                </div>
                <span
                  className={`text-sm px-3 py-1 rounded-full ${
                    stat.trend === "up"
                      ? "bg-[#10B981]/10 text-[#10B981]"
                      : "bg-[#EF4444]/10 text-[#EF4444]"
                  }`}
                >
                  {stat.change}
                </span>
              </div>
              <h3 className="text-2xl text-gray-900 mb-1">{stat.value}</h3>
              <p className="text-sm text-gray-600">{stat.label}</p>
            </motion.div>
          );
        })}
      </div>
      {/* الجداول البيانية  */}

      {/* Charts Row */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Revenue Chart */}
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ delay: 0.4 }}
          className="bg-white rounded-2xl shadow-md p-6"
        >
          <h2 className="text-xl text-gray-900 mb-4">الإيرادات الشهرية</h2>
          <ResponsiveContainer width="100%" height={400}>
            <LineChart data={revenueData}>
              <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
              <XAxis
                dataKey="month"
                stroke="#6B7280"
                style={{ fontSize: "14px", fontWeight: "500" }}
                tick={{ fill: "#374151" }}
                angle={0}
                dy={10}
              />
              <YAxis
                stroke="#6B7280"
                style={{ fontSize: "12px" }}
                tick={{ fill: "#374151" }}
                width={60}
              />
              <Tooltip
                contentStyle={{
                  backgroundColor: "#fff",
                  border: "1px solid #e5e7eb",
                  borderRadius: "12px",
                  padding: "12px",
                  fontSize: "14px",
                }}
              />
              <Legend />
              <Line
                type="monotone"
                dataKey="revenue"
                stroke="#2563EB"
                strokeWidth={3}
                name="الإيرادات (ر.س)"
                dot={{ fill: "#2563EB", r: 4 }}
              />
            </LineChart>
          </ResponsiveContainer>
        </motion.div>

        {/* Bookings by Room */}
        <motion.div
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ delay: 0.5 }}
          className="bg-white rounded-2xl shadow-md p-6"
        >
          <h2 className="text-xl text-gray-900 mb-4">الحجوزات حسب القاعة</h2>
          <ResponsiveContainer width="100%" height={400}>
            <BarChart data={roomsData}>
              <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
              <XAxis
                dataKey="name"
                stroke="#6B7280"
                style={{ fontSize: "14px", fontWeight: "500" }}
                tick={{ fill: "#374151" }}
                angle={0}
                dy={10}
              />
              <YAxis stroke="#6B7280" style={{ fontSize: "12px" }} />
              <Tooltip
                contentStyle={{
                  backgroundColor: "#fff",
                  border: "1px solid #e5e7eb",
                  borderRadius: "8px",
                }}
              />
              <Bar dataKey="bookings" name="عدد الحجوزات" radius={[8, 8, 0, 0]}>
                {roomsData.map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={entry.fill} />
                ))}
              </Bar>
            </BarChart>
          </ResponsiveContainer>
        </motion.div>
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
                  المبلغ
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  الحالة
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {recentBookings.map((booking) => {
                const statusBadge = getStatusBadge(booking.status);
                const StatusIcon = statusBadge.icon;
                return (
                  <tr
                    key={booking.id}
                    className="hover:bg-gray-50 transition-colors"
                  >
                    <td className="px-6 py-4 text-sm text-gray-900">
                      #{booking.id}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-900">
                      {booking.user}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {booking.room}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {booking.date}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-700">
                      {booking.time}
                    </td>
                    <td className="px-6 py-4 text-sm text-[#2563EB]">
                      {booking.amount} ر.س
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
        </div>
      </motion.div>
    </div>
  );
}
