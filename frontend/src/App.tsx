// App.tsx
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
//import { AuthProvider } from "./context/AuthContext";
//import { ProtectedRoute } from "./components/ProtectedRoute";

// Layouts
import { AdminLayout } from "./layouts/AdminLayout";

// Pages - Admin
import { Dashboard } from "./pages/admin/Dashboard";
import { RoomsManagement } from "./pages/admin/rooms-management";
import { TablesManagement } from "./pages/admin/tables-management";
import { BookingsManagement } from "./pages/admin/bookings-management";
import { EventsManagement } from "./pages/admin/Events-management";
import { PackagesManagement } from "./pages/admin/packages-management";
import { UsersManagement } from "./pages/admin/users-management";
import { Reports } from "./pages/admin/reports";

// Pages - Public
import { Login } from "./pages/Login";

function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Routes>
          {/* صفحة الدخول - بدون Sidebar */}
          <Route path="/login" element={<Login />} />

          {/* مسارات المدير - محمية */}
          <Route element={<ProtectedRoute allowedRoles={["admin"]} />}>
            <Route element={<AdminLayout />}>
              <Route path="/admin/dashboard" element={<Dashboard />} />
              <Route path="/admin/rooms" element={<RoomsManagement />} />
              <Route path="/admin/tables" element={<TablesManagement />} />
              <Route path="/admin/bookings" element={<BookingsManagement />} />
              <Route path="/admin/events" element={<EventsManagement />} />
              <Route path="/admin/packages" element={<PackagesManagement />} />
              <Route path="/admin/users" element={<UsersManagement />} />
              <Route path="/admin/reports" element={<Reports />} />
            </Route>
          </Route>

          {/* الصفحة الافتراضية */}
          <Route path="/" element={<Navigate to="/login" />} />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  );
}

export default App;
