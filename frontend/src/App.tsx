// App.tsx
import { Routes, Route, Navigate } from "react-router-dom";
//import { AuthProvider } from "./context/AuthContext";

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
import { useAuth } from "./context/GlobalState";
import { QRScanner } from "./pages/reception/qr-scanner";
import { ReceptionistDashboard } from "./pages/reception/receptionist-dashboard";
import { ReceptionistProfile } from "./pages/reception/receptionist-profile";
import { ActiveStudents } from "./pages/reception/active-students";

function App() {
  const { state } = useAuth();
  const { user, isAuthenticated } = state;
  return (
    <Routes>
      <Route path="/" element={<Navigate to="/login" replace />} />

      <Route path="/login" element={<Login />} />

      {isAuthenticated && user?.role_type === "admin" && (
        <Route path="/admin/*" element={<AdminLayout />}>
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="rooms" element={<RoomsManagement />} />
          <Route path="tables" element={<TablesManagement />} />
          <Route path="bookings" element={<BookingsManagement />} />
          <Route path="events" element={<EventsManagement />} />
          <Route path="packages" element={<PackagesManagement />} />
          <Route path="users" element={<UsersManagement />} />
          <Route path="reports" element={<Reports />} />
        </Route>
      )}

      {isAuthenticated && user?.role_type === "reception" && (
        <Route path="/reception" element={<ReceptionistDashboard />}>
          <Route path="QRScanner" element={<QRScanner />} />
          <Route path="ActiveStudents" element={<ActiveStudents />} />
          <Route path="ReceptionistProfile" element={<ReceptionistProfile />} />
          <Route path="TablesManagement" element={<TablesManagement />} />
        </Route>
      )}
    </Routes>
  );
}

export default App;
