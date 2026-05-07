// src/pages/reception/components/useQRScanner.ts
import { useState, useCallback } from "react";
import { bookingsAPI } from "../../APIMethod/bookings";

export type ScanMode = "checkin" | "checkout";

export interface ScanResult {
  success: boolean;
  studentName: string;
  studentId: string;
  tableName?: string;
  checkInTime?: string;
  checkOutTime?: string;
  duration?: string;
  totalPrice?: string;
  message: string;
}

export const useQRScanner = () => {
  const [isScanning, setIsScanning] = useState(false);
  const [scanResult, setScanResult] = useState<ScanResult | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // استخراج معرف الحجز من QR Code (يدعم الأرقام والنصوص)
  const extractBookingId = useCallback((qrData: string): string | null => {
    if (!qrData) return null;

    // إذا كان النص يحتوي على أرقام فقط، نعيده كرقم
    if (/^\d+$/.test(qrData)) {
      return qrData;
    }

    // إذا كان النص يحتوي على أرقام ضمنه، نستخرج الرقم الأول
    const match = qrData.match(/\d+/);
    if (match) {
      return match[0];
    }

    // في حالة النص الخالص (مثل "lanaalhabbal")، نعيد النص كما هو
    return qrData;
  }, []);

  // تنسيق التاريخ والوقت
  const formatDateTime = useCallback(
    (dateTimeString: string | null): string => {
      if (!dateTimeString) return "---";
      const date = new Date(dateTimeString);
      return date.toLocaleTimeString("ar-SA", {
        hour: "2-digit",
        minute: "2-digit",
        hour12: true,
      });
    },
    [],
  );

  // معالجة استجابة تسجيل الدخول
  const handleCheckInResponse = useCallback(
    (response: any): ScanResult => {
      const { data, message } = response;

      return {
        success: true,
        studentName: `حجز رقم ${data.id}`,
        studentId: `#${data.id}`,
        tableName: `طاولة رقم ${data.table?.table_num || "غير محدد"}`,
        checkInTime: formatDateTime(data.actual_start),
        message: message || "تم تسجيل الدخول بنجاح",
      };
    },
    [formatDateTime],
  );

  // معالجة استجابة تسجيل الخروج
  const handleCheckOutResponse = useCallback(
    (response: any): ScanResult => {
      const { data, message } = response;

      const hours = parseFloat(data.hours || "0");
      const totalPrice = parseFloat(data.total_price || "0");

      let detailsMessage = "";
      if (hours > 0) {
        detailsMessage = ` - المدة: ${hours.toFixed(2)} ساعة`;
        if (totalPrice > 0) {
          detailsMessage += ` - السعر: ${totalPrice.toFixed(2)} ريال`;
        }
      }

      return {
        success: true,
        studentName: `حجز رقم ${data.id}`,
        studentId: `#${data.id}`,
        tableName: `طاولة رقم ${data.table?.table_num || "غير محدد"}`,
        checkInTime: formatDateTime(data.actual_start),
        checkOutTime: formatDateTime(data.actual_end),
        duration: `${hours.toFixed(2)} ساعة`,
        totalPrice: `${totalPrice.toFixed(2)} ريال`,
        message: (message || " تم تسجيل الخروج بنجاح") + detailsMessage,
      };
    },
    [formatDateTime],
  );

  // معالجة الخطأ
  const handleError = useCallback((error: any): ScanResult => {
    let errorMessage = " فشلت العملية";

    if (error.response?.data?.message) {
      errorMessage = ` ${error.response.data.message}`;
    } else if (error.message) {
      errorMessage = ` ${error.message}`;
    }

    return {
      success: false,
      studentName: "---",
      studentId: "---",
      message: errorMessage,
    };
  }, []);

  // معالجة بيانات QR Code الأساسية
  const processQRData = useCallback(
    async (qrData: string, mode: ScanMode) => {
      if (loading) return;

      setLoading(true);
      setIsScanning(true);
      setError(null);
      setScanResult(null);

      try {
        const bookingId = extractBookingId(qrData);

        if (!bookingId) {
          throw new Error("بيانات QR غير صالحة");
        }

        let response;
        if (mode === "checkin") {
          response = await bookingsAPI.checkIn(bookingId);
          const result = handleCheckInResponse(response);
          setScanResult(result);
        } else {
          response = await bookingsAPI.checkOut(bookingId);
          const result = handleCheckOutResponse(response);
          setScanResult(result);
        }
      } catch (err: any) {
        console.error("QR Scan Error:", err);
        const errorResult = handleError(err);
        setScanResult(errorResult);
      } finally {
        setLoading(false);
        setIsScanning(false);
      }
    },
    [
      loading,
      extractBookingId,
      handleCheckInResponse,
      handleCheckOutResponse,
      handleError,
    ],
  );

  // إعادة تعيين حالة المسح
  const resetScan = useCallback(() => {
    setScanResult(null);
    setError(null);
    setLoading(false);
    setIsScanning(false);
  }, []);

  return {
    isScanning,
    scanResult,
    loading,
    error,
    processQRData,
    resetScan,
  };
};
