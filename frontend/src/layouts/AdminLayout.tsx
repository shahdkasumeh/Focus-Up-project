// layouts/AdminLayout.tsx
import { Outlet, useNavigate, useLocation } from "react-router-dom";
import { useAuth } from "../context/GlobalState";
import { Sidebar } from "../pages/admin/Sidebar";

export function AdminLayout() {
  const navigate = useNavigate();
  const location = useLocation();

  // استخراج الصفحة النشطة من الـ URL
  const activePage = location.pathname.split("/").pop() || "dashboard";

  const handleNavigate = (page: string) => {
    navigate(`/admin/${page}`);
  };

  return (
    <div className="min-h-screen bg-gray-50" dir="rtl">
      <Sidebar activePage={activePage} onNavigate={handleNavigate} />
      <div className="mr-64 min-h-screen">
        <div className="p-6">
          <Outlet />
        </div>
      </div>
    </div>
  );
}
