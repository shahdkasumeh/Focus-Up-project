import React, { useState } from "react";
import { motion, AnimatePresence } from "motion/react";
import {
  QrCode,
  ScanLine,
  CheckCircle2,
  XCircle,
  ArrowRight,
  User,
  Calendar,
  Clock,
  MapPin,
  AlertCircle,
} from "lucide-react";
import { Button } from "../../components/Button";

interface QRScannerProps {
  onBack: () => void;
}

type ScanMode = "checkin" | "checkout";

interface ScanResult {
  success: boolean;
  studentName: string;
  studentId: string;
  tableName?: string;
  checkInTime?: string;
  message: string;
}

export function QRScanner({ onBack }: QRScannerProps) {
  const [scanMode, setScanMode] = useState<ScanMode>("checkin");
  const [isScanning, setIsScanning] = useState(false);
  const [scanResult, setScanResult] = useState<ScanResult | null>(null);

  const handleScan = () => {
    setIsScanning(true);
    setScanResult(null);

    // محاكاة عملية المسح
    setTimeout(() => {
      setIsScanning(false);

      // نتيجة محاكاة
      const mockResult: ScanResult =
        scanMode === "checkin"
          ? {
              success: true,
              studentName: "محمد أحمد العتيبي",
              studentId: "STU-2024-001",
              tableName: "A-12",
              message: "تم تسجيل الدخول بنجاح",
            }
          : {
              success: true,
              studentName: "فاطمة علي الغامدي",
              studentId: "STU-2024-002",
              tableName: "B-05",
              checkInTime: "09:30 صباحاً",
              message: "تم تسجيل الخروج بنجاح",
            };

      setScanResult(mockResult);
    }, 2000);
  };

  const handleNewScan = () => {
    setScanResult(null);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-50">
      {/* Header */}
      <div className="bg-gradient-to-br from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-4xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <button
              onClick={onBack}
              className="p-2 hover:bg-white/10 rounded-xl transition-colors"
            >
              <ArrowRight className="w-6 h-6" />
            </button>
            <div>
              <h1 className="text-3xl mb-1">ماسح QR Code</h1>
              <p className="text-blue-100">تسجيل دخول وخروج الطلاب</p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-4xl mx-auto p-6">
        {/* Mode Selector */}
        <div className="bg-white rounded-2xl shadow-lg p-6 mb-6">
          <h2 className="text-xl text-gray-900 mb-4">اختر نوع العملية</h2>
          <div className="grid grid-cols-2 gap-4">
            <button
              onClick={() => {
                setScanMode("checkin");
                setScanResult(null);
              }}
              className={`p-6 rounded-xl border-2 transition-all ${
                scanMode === "checkin"
                  ? "border-[#ffbf1f] bg-[#ffbf1f]/10"
                  : "border-gray-200 hover:border-gray-300"
              }`}
            >
              <div className="flex flex-col items-center">
                <div
                  className={`w-16 h-16 rounded-2xl flex items-center justify-center mb-3 ${
                    scanMode === "checkin" ? "bg-[#ffbf1f]" : "bg-gray-100"
                  }`}
                >
                  <CheckCircle2
                    className={`w-8 h-8 ${
                      scanMode === "checkin"
                        ? "text-[#034363]"
                        : "text-gray-400"
                    }`}
                  />
                </div>
                <h3 className="text-lg font-semibold text-gray-900 mb-1">
                  تسجيل دخول
                </h3>
                <p className="text-sm text-gray-600 text-center">
                  تفعيل اشتراك الطالب
                </p>
              </div>
            </button>

            <button
              onClick={() => {
                setScanMode("checkout");
                setScanResult(null);
              }}
              className={`p-6 rounded-xl border-2 transition-all ${
                scanMode === "checkout"
                  ? "border-[#034363] bg-[#034363]/10"
                  : "border-gray-200 hover:border-gray-300"
              }`}
            >
              <div className="flex flex-col items-center">
                <div
                  className={`w-16 h-16 rounded-2xl flex items-center justify-center mb-3 ${
                    scanMode === "checkout" ? "bg-[#034363]" : "bg-gray-100"
                  }`}
                >
                  <XCircle
                    className={`w-8 h-8 ${
                      scanMode === "checkout" ? "text-white" : "text-gray-400"
                    }`}
                  />
                </div>
                <h3 className="text-lg font-semibold text-gray-900 mb-1">
                  تسجيل خروج
                </h3>
                <p className="text-sm text-gray-600 text-center">
                  إنهاء جلسة الطالب
                </p>
              </div>
            </button>
          </div>
        </div>

        {/* Scanner Area */}
        <div className="bg-white rounded-2xl shadow-lg p-8">
          <AnimatePresence mode="wait">
            {!scanResult ? (
              <motion.div
                key="scanner"
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.9 }}
                className="text-center"
              >
                <div className="relative inline-block mb-6">
                  {/* Scanner Frame */}
                  <div
                    className={`w-80 h-80 rounded-2xl border-4 ${
                      scanMode === "checkin"
                        ? "border-[#ffbf1f]"
                        : "border-[#034363]"
                    } flex items-center justify-center relative overflow-hidden bg-gradient-to-br ${
                      scanMode === "checkin"
                        ? "from-[#ffbf1f]/5 to-[#e6ac1c]/5"
                        : "from-[#034363]/5 to-[#045a85]/5"
                    }`}
                  >
                    {isScanning ? (
                      <motion.div
                        initial={{ y: -100 }}
                        animate={{ y: 300 }}
                        transition={{
                          duration: 2,
                          repeat: Infinity,
                          ease: "linear",
                        }}
                        className={`absolute w-full h-1 ${
                          scanMode === "checkin"
                            ? "bg-[#ffbf1f]"
                            : "bg-[#034363]"
                        } shadow-lg`}
                      />
                    ) : null}

                    <QrCode
                      className={`w-32 h-32 ${
                        isScanning
                          ? "text-gray-300"
                          : scanMode === "checkin"
                            ? "text-[#ffbf1f]"
                            : "text-[#034363]"
                      }`}
                    />
                  </div>

                  {/* Corner Markers */}
                  <div className="absolute top-0 left-0 w-8 h-8 border-t-4 border-l-4 border-[#ffbf1f] rounded-tl-xl" />
                  <div className="absolute top-0 right-0 w-8 h-8 border-t-4 border-r-4 border-[#ffbf1f] rounded-tr-xl" />
                  <div className="absolute bottom-0 left-0 w-8 h-8 border-b-4 border-l-4 border-[#ffbf1f] rounded-bl-xl" />
                  <div className="absolute bottom-0 right-0 w-8 h-8 border-b-4 border-r-4 border-[#ffbf1f] rounded-br-xl" />
                </div>

                <h3 className="text-2xl text-gray-900 mb-3">
                  {isScanning
                    ? "جاري المسح..."
                    : `جاهز لـ${scanMode === "checkin" ? "تسجيل الدخول" : "تسجيل الخروج"}`}
                </h3>
                <p className="text-gray-600 mb-6">
                  {isScanning
                    ? "يرجى الانتظار..."
                    : "قم بوضع رمز QR الخاص بالطالب أمام الكاميرا"}
                </p>

                <Button
                  onClick={handleScan}
                  disabled={isScanning}
                  variant="primary"
                  size="lg"
                  className="w-full max-w-xs"
                >
                  {isScanning ? (
                    <>
                      <motion.div
                        animate={{ rotate: 360 }}
                        transition={{
                          duration: 1,
                          repeat: Infinity,
                          ease: "linear",
                        }}
                      >
                        <ScanLine className="w-5 h-5 ml-2" />
                      </motion.div>
                      جاري المسح...
                    </>
                  ) : (
                    <>
                      <QrCode className="w-5 h-5 ml-2" />
                      بدء المسح
                    </>
                  )}
                </Button>
              </motion.div>
            ) : (
              <motion.div
                key="result"
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.9 }}
                className="text-center"
              >
                {/* Success/Error Icon */}
                <motion.div
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  transition={{ type: "spring", duration: 0.6 }}
                  className={`inline-flex items-center justify-center w-24 h-24 rounded-full mb-6 ${
                    scanResult.success
                      ? scanMode === "checkin"
                        ? "bg-[#ffbf1f]"
                        : "bg-[#034363]"
                      : "bg-[#EF4444]"
                  }`}
                >
                  {scanResult.success ? (
                    <CheckCircle2
                      className={`w-12 h-12 ${
                        scanMode === "checkin" ? "text-[#034363]" : "text-white"
                      }`}
                    />
                  ) : (
                    <AlertCircle className="w-12 h-12 text-white" />
                  )}
                </motion.div>

                <h3 className="text-3xl text-gray-900 mb-2">
                  {scanResult.message}
                </h3>

                {/* Student Info */}
                <div className="bg-gray-50 rounded-2xl p-6 mt-6 text-right max-w-md mx-auto">
                  <div className="space-y-4">
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 bg-[#034363]/10 rounded-xl flex items-center justify-center">
                        <User className="w-5 h-5 text-[#034363]" />
                      </div>
                      <div className="flex-1">
                        <p className="text-sm text-gray-600">اسم الطالب</p>
                        <p className="text-lg font-semibold text-gray-900">
                          {scanResult.studentName}
                        </p>
                      </div>
                    </div>

                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 bg-[#ffbf1f]/10 rounded-xl flex items-center justify-center">
                        <Calendar className="w-5 h-5 text-[#ffbf1f]" />
                      </div>
                      <div className="flex-1">
                        <p className="text-sm text-gray-600">رقم الطالب</p>
                        <p className="text-lg font-semibold text-gray-900">
                          {scanResult.studentId}
                        </p>
                      </div>
                    </div>

                    {scanResult.tableName && (
                      <div className="flex items-center gap-3">
                        <div className="w-10 h-10 bg-[#10B981]/10 rounded-xl flex items-center justify-center">
                          <MapPin className="w-5 h-5 text-[#10B981]" />
                        </div>
                        <div className="flex-1">
                          <p className="text-sm text-gray-600">الطاولة</p>
                          <p className="text-lg font-semibold text-gray-900">
                            {scanResult.tableName}
                          </p>
                        </div>
                      </div>
                    )}

                    {scanResult.checkInTime && (
                      <div className="flex items-center gap-3">
                        <div className="w-10 h-10 bg-[#034363]/10 rounded-xl flex items-center justify-center">
                          <Clock className="w-5 h-5 text-[#034363]" />
                        </div>
                        <div className="flex-1">
                          <p className="text-sm text-gray-600">
                            وقت تسجيل الدخول
                          </p>
                          <p className="text-lg font-semibold text-gray-900">
                            {scanResult.checkInTime}
                          </p>
                        </div>
                      </div>
                    )}
                  </div>
                </div>

                <div className="mt-6 space-y-3">
                  <Button
                    onClick={handleNewScan}
                    variant="primary"
                    size="lg"
                    className="w-full max-w-xs"
                  >
                    مسح آخر
                  </Button>
                  <Button
                    onClick={onBack}
                    variant="outline"
                    size="lg"
                    className="w-full max-w-xs"
                  >
                    العودة للوحة التحكم
                  </Button>
                </div>
              </motion.div>
            )}
          </AnimatePresence>
        </div>

        {/* Instructions */}
        {!scanResult && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="mt-6 bg-blue-50 rounded-2xl p-6"
          >
            <h3 className="text-lg font-semibold text-[#034363] mb-3 flex items-center gap-2">
              <AlertCircle className="w-5 h-5" />
              إرشادات الاستخدام
            </h3>
            <ul className="space-y-2 text-gray-700">
              <li className="flex items-start gap-2">
                <span className="text-[#ffbf1f] mt-1">•</span>
                <span>تأكد من وضوح رمز QR أمام الكاميرا</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#ffbf1f] mt-1">•</span>
                <span>احرص على وجود إضاءة جيدة</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#ffbf1f] mt-1">•</span>
                <span>انتظر حتى اكتمال عملية المسح</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#ffbf1f] mt-1">•</span>
                <span>في حالة فشل المسح، حاول مرة أخرى</span>
              </li>
            </ul>
          </motion.div>
        )}
      </div>
    </div>
  );
}
