import React, { useState } from "react";
import { motion } from "motion/react";
import {
  Download,
  Calendar,
  TrendingUp,
  DollarSign,
  Users,
  Building2,
  FileText,
  BarChart3,
} from "lucide-react";
import {
  LineChart,
  Line,
  BarChart,
  Bar,
  PieChart,
  Pie,
  Cell,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";
import { Button } from "../../components/Button";

const monthlyRevenue = [
  { month: "يناير", revenue: 28000, bookings: 245, users: 180 },
  { month: "فبراير", revenue: 32000, bookings: 298, users: 210 },
  { month: "مارس", revenue: 35000, bookings: 320, users: 245 },
  { month: "أبريل", revenue: 38000, bookings: 356, users: 280 },
  { month: "مايو", revenue: 42000, bookings: 389, users: 315 },
  { month: "يونيو", revenue: 45280, bookings: 412, users: 350 },
];

const roomsPerformance = [
  { name: "قاعة النجاح", revenue: 12500, bookings: 145, occupancy: 85 },
  { name: "قاعة الإبداع", revenue: 9800, bookings: 98, occupancy: 72 },
  { name: "قاعة الهدوء", revenue: 15600, bookings: 167, occupancy: 92 },
  { name: "قاعة التفوق", revenue: 11200, bookings: 112, occupancy: 68 },
  { name: "قاعة المعرفة", revenue: 18900, bookings: 201, occupancy: 78 },
];

const timeSlotData = [
  { slot: "08:00-12:00", bookings: 245 },
  { slot: "12:00-14:00", bookings: 89 },
  { slot: "14:00-18:00", bookings: 412 },
  { slot: "18:00-22:00", bookings: 298 },
];

const paymentMethods = [
  { name: "بطاقة ائتمانية", value: 65, fill: "#2563EB" },
  { name: "محفظة إلكترونية", value: 25, fill: "#10B981" },
  { name: "نقداً", value: 10, fill: "#F59E0B" },
];

export function Reports() {
  const [dateRange, setDateRange] = useState("month");

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl text-gray-900 mb-2">التقارير والتحليلات</h1>
          <p className="text-gray-600">تحليلات متقدمة للأداء والإيرادات</p>
        </div>
        <div className="flex gap-3">
          <select
            className="px-4 py-3 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#2563EB]"
            value={dateRange}
            onChange={(e) => setDateRange(e.target.value)}
          >
            <option value="week">آخر أسبوع</option>
            <option value="month">آخر شهر</option>
            <option value="quarter">آخر 3 أشهر</option>
            <option value="year">آخر سنة</option>
          </select>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-gradient-to-br from-[#035177] to-[#035177] text-white rounded-2xl shadow-lg p-6"
        >
          <div className="flex items-start justify-between mb-4">
            <DollarSign className="w-10 h-10 opacity-80" />
            <TrendingUp className="w-5 h-5" />
          </div>
          <p className="text-sm opacity-90 mb-1">إجمالي الإيرادات</p>
          <p className="text-3xl mb-2">45,280 ر.س</p>
          <p className="text-sm opacity-80">+15.3% عن الشهر الماضي</p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="bg-gradient-to-br from-[#219ebc] to-[#219ebc] text-white rounded-2xl shadow-lg p-6"
        >
          <div className="flex items-start justify-between mb-4">
            <Calendar className="w-10 h-10 opacity-80" />
            <TrendingUp className="w-5 h-5" />
          </div>
          <p className="text-sm opacity-90 mb-1">إجمالي الحجوزات</p>
          <p className="text-3xl mb-2">1,284</p>
          <p className="text-sm opacity-80">+12.5% عن الشهر الماضي</p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="bg-gradient-to-br from-[#ffb703] to-[#ffb703] text-white rounded-2xl shadow-lg p-6"
        >
          <div className="flex items-start justify-between mb-4">
            <Users className="w-10 h-10 opacity-80" />
            <TrendingUp className="w-5 h-5" />
          </div>
          <p className="text-sm opacity-90 mb-1">المستخدمين النشطين</p>
          <p className="text-3xl mb-2">856</p>
          <p className="text-sm opacity-80">+8.2% عن الشهر الماضي</p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="bg-gradient-to-br from-[#8ecae6] to-[#8ecae6] text-white rounded-2xl shadow-lg p-6"
        >
          <div className="flex items-start justify-between mb-4">
            <Building2 className="w-10 h-10 opacity-80" />
            <TrendingUp className="w-5 h-5" />
          </div>
          <p className="text-sm opacity-90 mb-1">معدل الإشغال</p>
          <p className="text-3xl mb-2">78%</p>
          <p className="text-sm opacity-80">+5.1% عن الشهر الماضي</p>
        </motion.div>
      </div>

      {/* Revenue Trend */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.4 }}
        className="bg-white rounded-2xl shadow-md p-6"
      >
        <h2 className="text-xl text-gray-900 mb-6">تطور الإيرادات والحجوزات</h2>
        <ResponsiveContainer width="100%" height={350}>
          <AreaChart data={monthlyRevenue}>
            <defs>
              <linearGradient id="colorRevenue" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#2563EB" stopOpacity={0.3} />
                <stop offset="95%" stopColor="#2563EB" stopOpacity={0} />
              </linearGradient>
              <linearGradient id="colorBookings" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#10B981" stopOpacity={0.3} />
                <stop offset="95%" stopColor="#10B981" stopOpacity={0} />
              </linearGradient>
            </defs>
            <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
            <XAxis
              dataKey="month"
              stroke="#6B7280"
              style={{ fontSize: "12px" }}
            />
            <YAxis stroke="#6B7280" style={{ fontSize: "12px" }} />
            <Tooltip
              contentStyle={{
                backgroundColor: "#fff",
                border: "1px solid #e5e7eb",
                borderRadius: "12px",
              }}
            />
            <Legend />
            <Area
              type="monotone"
              dataKey="revenue"
              stroke="#2563EB"
              fillOpacity={1}
              fill="url(#colorRevenue)"
              name="الإيرادات (ر.س)"
            />
            <Area
              type="monotone"
              dataKey="bookings"
              stroke="#10B981"
              fillOpacity={1}
              fill="url(#colorBookings)"
              name="الحجوزات"
            />
          </AreaChart>
        </ResponsiveContainer>
      </motion.div>

      {/* Two Column Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Rooms Performance */}
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ delay: 0.5 }}
          className="bg-white rounded-2xl shadow-md p-6"
        >
          <h2 className="text-xl text-gray-900 mb-6">أداء القاعات</h2>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={roomsPerformance} layout="vertical">
              <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
              <XAxis
                type="number"
                stroke="#6B7280"
                style={{ fontSize: "12px" }}
              />
              <YAxis
                dataKey="name"
                type="category"
                stroke="#6B7280"
                style={{ fontSize: "11px" }}
                width={100}
              />
              <Tooltip
                contentStyle={{
                  backgroundColor: "#fff",
                  border: "1px solid #e5e7eb",
                  borderRadius: "12px",
                }}
              />
              <Bar
                dataKey="revenue"
                fill="#2563EB"
                radius={[0, 8, 8, 0]}
                name="الإيرادات (ر.س)"
              />
            </BarChart>
          </ResponsiveContainer>
        </motion.div>

        {/* Payment Methods */}
        <motion.div
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ delay: 0.6 }}
          className="bg-white rounded-2xl shadow-md p-6"
        >
          <h2 className="text-xl text-gray-900 mb-6">طرق الدفع</h2>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={paymentMethods}
                cx="50%"
                cy="50%"
                innerRadius={60}
                outerRadius={100}
                paddingAngle={5}
                dataKey="value"
                label={(entry) => `${entry.value}%`}
              >
                {paymentMethods.map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={entry.fill} />
                ))}
              </Pie>
              <Tooltip />
              <Legend />
            </PieChart>
          </ResponsiveContainer>
        </motion.div>
      </div>

      {/* Time Slots Analysis */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.7 }}
        className="bg-white rounded-2xl shadow-md p-6"
      >
        <h2 className="text-xl text-gray-900 mb-6">
          الحجوزات حسب الفترة الزمنية
        </h2>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart data={timeSlotData}>
            <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
            <XAxis
              dataKey="slot"
              stroke="#6B7280"
              style={{ fontSize: "12px" }}
            />
            <YAxis stroke="#6B7280" style={{ fontSize: "12px" }} />
            <Tooltip
              contentStyle={{
                backgroundColor: "#fff",
                border: "1px solid #e5e7eb",
                borderRadius: "12px",
              }}
            />
            <Bar
              dataKey="bookings"
              fill="#F59E0B"
              radius={[8, 8, 0, 0]}
              name="عدد الحجوزات"
            />
          </BarChart>
        </ResponsiveContainer>
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
                  الإيرادات
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  معدل الإشغال
                </th>
                <th className="px-6 py-4 text-right text-sm text-gray-600">
                  الأداء
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
                      <span className="text-sm text-gray-900">{room.name}</span>
                    </div>
                  </td>
                  <td className="px-6 py-4 text-sm text-gray-700">
                    {room.bookings}
                  </td>
                  <td className="px-6 py-4 text-sm text-[#2563EB]">
                    {room.revenue} ر.س
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-3">
                      <div className="flex-1 bg-gray-200 rounded-full h-2 max-w-[100px]">
                        <div
                          className="bg-[#10B981] h-2 rounded-full"
                          style={{ width: `${room.occupancy}%` }}
                        />
                      </div>
                      <span className="text-sm text-gray-700">
                        {room.occupancy}%
                      </span>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <span
                      className={`inline-flex px-3 py-1 rounded-full text-xs ${
                        room.occupancy >= 80
                          ? "bg-[#10B981]/10 text-[#10B981]"
                          : room.occupancy >= 60
                            ? "bg-[#F59E0B]/10 text-[#F59E0B]"
                            : "bg-[#EF4444]/10 text-[#EF4444]"
                      }`}
                    >
                      {room.occupancy >= 80
                        ? "ممتاز"
                        : room.occupancy >= 60
                          ? "جيد"
                          : "ضعيف"}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </motion.div>
    </div>
  );
}
