// App.tsx
import { Routes, Route, Navigate } from "react-router-dom";
//import { AuthProvider } from "./context/AuthContext";

// Layouts
import { AdminLayout } from "./layouts/AdminLayout";

// Pages - Admin
import { Dashboard } from "./pages/admin/Dashboard";
import { RoomsManagement } from "./pages/admin/rooms-management";
import { AdminTablesManagement } from "./pages/admin/Admin-tables-management";
import { BookingsManagement } from "./pages/admin/bookings-management";
import { PackagesManagement } from "./pages/admin/packages-management";
import { WheelManagement } from "./pages/admin/wheel-management";

// Pages - Public
import { Login } from "./pages/Login";
import { useAuth } from "./context/GlobalState";
import { QRScanner } from "./pages/reception/qr-scanner";
import { ReceptionistDashboard } from "./pages/reception/receptionist-dashboard";
import { ActiveStudents } from "./pages/reception/active-students";
import { ReceptionTablesManagement } from "./pages/reception/Reception-tables-management";
import { ReceptionistPackageManagement } from "./pages/reception/receptionist-package_management";

function App() {
  const { state } = useAuth();
  const { user, isAuthenticated } = state;
  return (
    <Routes>
      <Route path="/" element={<Navigate to="/login" replace />} />

      <Route path="/login" element={<Login />} />

      {isAuthenticated && user?.role === "admin" && (
        <Route path="/admin" element={<AdminLayout />}>
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="rooms" element={<RoomsManagement />} />
          <Route path="tables" element={<AdminTablesManagement />} />
          <Route path="bookings" element={<BookingsManagement />} />
          <Route path="packages" element={<PackagesManagement />} />
          <Route path="wheel" element={<WheelManagement />} />
        </Route>
      )}

      {isAuthenticated && user?.role === "receptionist" && (
        <>
          <Route path="/reception" element={<ReceptionistDashboard />} />
          <Route path="/reception/QRScanner" element={<QRScanner />} />
          <Route
            path="/reception/ActiveStudents"
            element={<ActiveStudents />}
          />
          <Route
            path="/reception/ReceptionistPackageManagement"
            element={<ReceptionistPackageManagement />}
          />
          <Route
            path="/reception/TablesManagement"
            element={<ReceptionTablesManagement />}
          />
        </>
      )}
    </Routes>
  );
}

export default App;
