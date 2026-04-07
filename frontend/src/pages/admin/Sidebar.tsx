// pages/admin/Sidebar.tsx (نسخة مبسطة)
import {
  LayoutDashboard,
  Building2,
  Users,
  Calendar,
  FileText,
  Settings,
  LogOut,
  Table,
  CalendarDays,
  Package,
} from "lucide-react";

interface SidebarProps {
  activePage: string;
  onNavigate: (page: string) => void;
  onLogout?: () => void;
}

const menuItems = [
  { id: "dashboard", label: "لوحة التحكم", icon: LayoutDashboard },
  { id: "rooms", label: "إدارة القاعات", icon: Building2 },
  { id: "tables", label: "إدارة الطاولات", icon: Table },
  { id: "bookings", label: "إدارة الحجوزات", icon: Calendar },
  { id: "events", label: "إدارة الفعاليات", icon: CalendarDays },
  { id: "packages", label: "إدارة الباقات", icon: Package },
  { id: "users", label: "إدارة المستخدمين", icon: Users },
  { id: "reports", label: "التقارير", icon: FileText },
  { id: "settings", label: "الإعدادات", icon: Settings },
];

export function Sidebar({ activePage, onNavigate, onLogout }: SidebarProps) {
  return (
    <div className="fixed right-0 top-0 w-64 h-screen bg-gray-900 text-white flex flex-col shadow-2xl">
      {/* Header */}
      <div className="p-6 border-b border-gray-800">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-gradient-to-br from-[#ffbf1f] to-[#e6ac1c] rounded-xl flex items-center justify-center">
            <LayoutDashboard className="w-5 h-5 text-[#034363]" />
          </div>
          <div>
            <h1 className="text-lg font-bold">لوحة التحكم</h1>
            <p className="text-xs text-gray-400">نظام إدارة الحجوزات</p>
          </div>
        </div>
      </div>

      {/* Menu */}
      <nav className="flex-1 p-4 overflow-y-auto">
        <div className="space-y-2">
          {menuItems.map((item) => {
            const Icon = item.icon;
            const isActive = activePage === item.id;
            return (
              <button
                key={item.id}
                onClick={() => onNavigate(item.id)}
                className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl transition-all text-right ${
                  isActive
                    ? "bg-gradient-to-r from-[#ffbf1f] to-[#e6ac1c] text-[#034363] shadow-lg"
                    : "text-gray-400 hover:bg-gray-800 hover:text-white"
                }`}
              >
                <Icon className="w-5 h-5" />
                <span className="flex-1">{item.label}</span>
              </button>
            );
          })}
        </div>
      </nav>

      {/* Logout */}
      <div className="p-4 border-t border-gray-800">
        <button
          onClick={onLogout}
          className="w-full flex items-center gap-3 px-4 py-3 rounded-xl text-[#EF4444] hover:bg-[#EF4444]/10 transition-all text-right"
        >
          <LogOut className="w-5 h-5" />
          <span className="flex-1">تسجيل الخروج</span>
        </button>
      </div>
    </div>
  );
}
