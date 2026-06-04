import React, { useState, useEffect } from "react";
import { motion } from "motion/react";
import { useAuth } from "../../context/GlobalState";
import {
  QrCode,
  Users,
  Table,
  CheckCircle2,
  XCircle,
  Package,
  RefreshCw,
} from "lucide-react";
import { useNavigate } from "react-router-dom";
import { tablesApi } from "../../APIMethod/tables";
import { bookingsAPI, BookingDetails } from "../../APIMethod/bookings";

interface DashboardStats {
  availableTables: number;
  reservedTables: number;
  totalTables: number;
  todayCheckIns: number;
  todayCheckOuts: number;
}

export function ReceptionistDashboard() {
  const navigate = useNavigate();
  const { state } = useAuth();
  const { bookingDetails } = state;
  const [searchQuery, setSearchQuery] = useState("");
  const [stats, setStats] = useState<DashboardStats>({
    availableTables: 0,
    reservedTables: 0,
    totalTables: 0,
    todayCheckIns: 0,
    todayCheckOuts: 0,
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [lastUpdated, setLastUpdated] = useState<Date | null>(null);

  const fetchStats = async () => {
    setLoading(true);
    setError(null);
    try {
      const [tablesRes, bookingsRes] = await Promise.all([
        tablesApi.getAllTables(),
        bookingsAPI.getBookingDetails(),
      ]);
      const tables = tablesRes.data;
      const bookings: BookingDetails[] = bookingsRes.data;
      const availableTables = tables.filter(
        (t) => t.is_active === 1 && t.is_occupied === 0,
      ).length;
      const reservedTables = tables.filter((t) => t.is_occupied === 1).length;
      const today = new Date().toISOString().split("T")[0];
      const todayCheckIns = bookings.filter((b) =>
        b.actual_start?.startsWith(today),
      ).length;
      const todayCheckOuts = bookings.filter((b) =>
        b.actual_end?.startsWith(today),
      ).length;
      setStats({
        availableTables,
        reservedTables,
        totalTables: tables.length,
        todayCheckIns,
        todayCheckOuts,
      });

      setLastUpdated(new Date());
    } catch (err) {
      console.error("فشل تحميل الإحصائيات:", err);
      setError("تعذّر تحميل البيانات. تحقق من الاتصال وأعد المحاولة.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchStats();
  }, []);

  const activeStudentsCount = bookingDetails.filter(
    (b) => b.status === "active",
  ).length;

  const quickActions = [
    {
      id: "scan-checkin",
      title: "مسح QR - تسجيل دخول",
      description: "تفعيل اشتراك الطالب",
      icon: QrCode,
      color: "from-[#ffbf1f] to-[#e6ac1c]",
      textColor: "text-[#034363]",
      onClick: () => navigate("/reception/QRScanner"),
    },
    {
      id: "tables",
      title: "إدارة الطاولات",
      description: "عرض وتحديث حالة الطاولات",
      icon: Table,
      color: "from-[#034363] to-[#045a85]",
      textColor: "text-white",
      onClick: () => navigate("/reception/TablesManagement"),
    },
    {
      id: "students",
      title: "الطلاب الحاليين",
      description: "عرض الطلاب المتواجدين",
      icon: Users,
      color: "from-[#10B981] to-[#059669]",
      textColor: "text-white",
      onClick: () => navigate("/reception/ActiveStudents"),
    },
    {
      id: "profile",
      title: "إدارة الباقات",
      description: "تعديل حالة الباقات",
      icon: Package,
      color: "from-[#f0f8fc] to-[#e0f2fe]",
      textColor: "text-[#034363]",
      onClick: () => navigate("/reception/ReceptionistPackageManagement"),
    },
  ];

  return (
    <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50">
      {/* ── Header ── */}
      <div className="bg-linear-to-br from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-7xl mx-auto">
          {/* Title row */}
          <div className="flex items-center justify-between mb-6">
            <div>
              <h1 className="text-3xl mb-1">لوحة موظف الاستقبال</h1>
            </div>

            <div className="flex items-center gap-3">
              <button
                onClick={fetchStats}
                disabled={loading}
                className="p-2 bg-white/10 hover:bg-white/20 rounded-xl transition-colors disabled:opacity-50"
                title="تحديث البيانات"
              >
                <RefreshCw
                  className={`w-5 h-5 ${loading ? "animate-spin" : ""}`}
                />
              </button>

              <button
                onClick={() => navigate("/login")}
                className="px-4 py-2 bg-white/10 hover:bg-white/20 rounded-xl transition-colors"
              >
                تسجيل الخروج
              </button>
            </div>
          </div>

          {/* ── Stats Cards ── */}
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-4"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-blue-100 mb-1">الطلاب الحاليين</p>
                  <p className="text-3xl font-bold">{activeStudentsCount}</p>
                </div>
                <div className="w-12 h-12 bg-[#ffbf1f] rounded-xl flex items-center justify-center">
                  <Users className="w-6 h-6 text-[#034363]" />
                </div>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-4"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-blue-100 mb-1">طاولات متاحة</p>
                  <p className="text-3xl font-bold">
                    {loading ? (
                      <span className="animate-pulse">...</span>
                    ) : (
                      stats.availableTables
                    )}
                  </p>
                </div>
                <div className="w-12 h-12 bg-[#10B981] rounded-xl flex items-center justify-center">
                  <CheckCircle2 className="w-6 h-6 text-white" />
                </div>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 }}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-4"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-blue-100 mb-1">تسجيلات اليوم</p>
                  <p className="text-3xl font-bold">
                    {loading ? (
                      <span className="animate-pulse">...</span>
                    ) : (
                      stats.todayCheckIns
                    )}
                  </p>
                </div>
                <div className="w-12 h-12 bg-[#ffbf1f] rounded-xl flex items-center justify-center">
                  <CheckCircle2 className="w-6 h-6 text-[#034363]" />
                </div>
              </div>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.3 }}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-4"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-blue-100 mb-1">مغادرات اليوم</p>
                  <p className="text-3xl font-bold">
                    {loading ? (
                      <span className="animate-pulse">...</span>
                    ) : (
                      stats.todayCheckOuts
                    )}
                  </p>
                </div>
                <div className="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center">
                  <XCircle className="w-6 h-6 text-white" />
                </div>
              </div>
            </motion.div>
          </div>
        </div>
      </div>

      {/* ── Quick Actions ── */}
      <div className="max-w-7xl mx-auto p-6">
        <h2 className="text-2xl text-gray-900 mb-6">الإجراءات السريعة</h2>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {quickActions.map((action, index) => (
            <motion.button
              key={action.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              className="group"
              onClick={action.onClick}
            >
              <div
                className={`bg-linear-to-br ${action.color} rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-105`}
              >
                <div className="flex flex-col items-center text-center">
                  <div
                    className={`w-16 h-16 ${
                      action.textColor === "text-white"
                        ? "bg-white/20"
                        : "bg-[#034363]/10"
                    } rounded-2xl flex items-center justify-center mb-4`}
                  >
                    <action.icon className={`w-8 h-8 ${action.textColor}`} />
                  </div>
                  <h3
                    className={`text-lg font-semibold mb-2 ${action.textColor}`}
                  >
                    {action.title}
                  </h3>
                  <p className={`text-sm ${action.textColor} opacity-80`}>
                    {action.description}
                  </p>
                </div>
              </div>
            </motion.button>
          ))}
        </div>
      </div>
    </div>
  );
}
