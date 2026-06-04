// src/pages/reception/components/useQRScanner.ts
import { useState, useCallback, useRef } from "react";
import { bookingsAPI } from "../../APIMethod/bookings";

export type ScanMode = "checkin" | "checkout";

export interface ScanResult {
  success: boolean;
  studentName: string;
  studentId: string;
  status?: string;
  tableName?: string;
  scheduledStart?: string;
  scheduledEnd?: string;
  checkInTime?: string;
  checkOutTime?: string;
  hours?: string;
  rawPrice?: string;
  discountPercent?: string;
  discountAmount?: string;
  duration?: string;
  totalPrice?: string;
  paymentLabel?: string;
  action?: string;
  message: string;
}

export const useQRScanner = () => {
  const [isScanning, setIsScanning] = useState(false);
  const [scanResult, setScanResult] = useState<ScanResult | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const scannedIdRef = useRef<number | null>(null);

  const extractBookingId = useCallback((qrData: string): string | null => {
    if (!qrData) return null;
    if (/^\d+$/.test(qrData)) {
      return qrData;
    }
    const match = qrData.match(/\d+/);
    if (match) {
      return match[0];
    }
    return qrData;
  }, []);

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

  const handleCheckInResponse = useCallback(
    (response: any): ScanResult => {
      const { data, message } = response;

      if (!data) {
        return {
          success: false,
          studentName: "---",
          studentId: "---",
          message: message || "لا توجد جلسة نشطة",
        };
      }

      return {
        success: true,
        studentName: `حجز رقم ${data.id}`,
        studentId: `#${data.id}`,
        status: data.status,
        scheduledStart: formatDateTime(data.scheduled_start),
        scheduledEnd: formatDateTime(data.scheduled_end),
        checkInTime: formatDateTime(data.actual_start),
        checkOutTime: formatDateTime(data.actual_end),
        hours: data.hours,
        rawPrice: data.raw_price,
        discountPercent: data.discount_percent,
        discountAmount: data.discount_amount,
        totalPrice: data.total_price,
        paymentLabel: data.payment_label,
        action: data.action,
        message: message || "تم تسجيل الدخول بنجاح",
      };
    },
    [formatDateTime],
  );

  const handleCheckOutResponse = useCallback(
    (response: any): ScanResult => {
      const { data, message } = response;

      if (!data) {
        return {
          success: false,
          studentName: "---",
          studentId: "---",
          message: message || "لا توجد جلسة",
        };
      }

      return {
        success: true,
        studentName: `حجز رقم ${data.id}`,
        studentId: `#${data.id}`,
        status: data.status,
        action: data.action, 
        checkInTime: formatDateTime(data.actual_start),
        checkOutTime: formatDateTime(data.actual_end),
        scheduledStart: formatDateTime(data.scheduled_start),
        scheduledEnd: formatDateTime(data.scheduled_end),
        hours: data.hours,
        rawPrice: data.raw_price, 
        discountPercent: data.discount_percent, 
        discountAmount: data.discount_amount,
        totalPrice: data.total_price,
        paymentLabel: data.payment_label, 
        message: message || "تم تسجيل الخروج بنجاح",
      };
    },
    [formatDateTime],
  );

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

  const processQRData = useCallback(
    async (mode: ScanMode, qrData: string) => {
      if (loading) return;

      setLoading(true);
      setIsScanning(true);
      setError(null);
      setScanResult(null);

      try {
        let parsedData: { booking_id: number | null; token: string };

        try {
          parsedData = JSON.parse(qrData);
        } catch {
          setScanResult({
            success: false,
            studentName: "---",
            studentId: "---",
            message: "QR Code غير صالح",
          });
          return;
        }

        const { booking_id, token } = parsedData;

        if (!token) {
          setScanResult({
            success: false,
            studentName: "---",
            studentId: "---",
            message: "بيانات QR ناقصة",
          });
          return;
        }

        scannedIdRef.current = booking_id;

        let response;
        if (mode === "checkin") {
          response = await bookingsAPI.checkIn(booking_id, token); 
          setScanResult(handleCheckInResponse(response));
        } else {
          response = await bookingsAPI.checkOut(booking_id, token); 
          setScanResult(handleCheckOutResponse(response));
        }
      } catch (err: any) {
        setScanResult(handleError(err));
      } finally {
        setLoading(false);
        setIsScanning(false);
        scannedIdRef.current = null;
      }
    },
    [loading, handleCheckInResponse, handleCheckOutResponse, handleError],
  );

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
