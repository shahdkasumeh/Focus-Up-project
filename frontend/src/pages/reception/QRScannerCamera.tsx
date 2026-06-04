import React, { useState, useEffect, useRef } from "react";
import { Html5QrcodeScanner } from "html5-qrcode";
import { Button } from "../../components/Button";
import { Camera, CameraOff, Loader2, AlertCircle } from "lucide-react";

interface QRScannerCameraProps {
  onScan: (qrData: string) => void;
  isScanning: boolean;
  onClose?: () => void;
}

export const QRScannerCamera: React.FC<QRScannerCameraProps> = ({
  onScan,
  isScanning,
  onClose,
}) => {
  const [cameraActive, setCameraActive] = useState(false);
  const [cameraError, setCameraError] = useState<string | null>(null);
  const [hasScanned, setHasScanned] = useState(false);
  const [debugLog, setDebugLog] = useState<string>("");
  const scannerRef = useRef<Html5QrcodeScanner | null>(null);
  const containerId = "qr-reader-container";

  useEffect(() => {
    return () => {
      if (scannerRef.current) {
        scannerRef.current.clear();
        scannerRef.current = null;
      }
    };
  }, []);

  useEffect(() => {
    if (cameraActive && !scannerRef.current) {
      setTimeout(() => {
        startScanner();
      }, 200);
    }
  }, [cameraActive]);

  const addDebugLog = (msg: string) => {
    console.log(msg);
    setDebugLog(msg);
    setTimeout(() => setDebugLog(""), 3000);
  };

  const startScanner = () => {
    if (!cameraActive) return;

    addDebugLog("بدء تشغيل الماسح...");

    const existingContainer = document.getElementById(containerId);
    if (existingContainer) {
      existingContainer.innerHTML = "";
    }

    const scanner = new Html5QrcodeScanner(
      containerId,
      {
        fps: 30,
        qrbox: { width: 300, height: 300 },
        aspectRatio: 1,
        disableFlip: false,
        videoConstraints: {
          facingMode: "user",
        },
      },
      true,
    );

    scanner.render(onScanSuccess, onScanError);
    scannerRef.current = scanner;
    addDebugLog("الماسح يعمل، قرب QR Code من الكاميرا");
  };

  const onScanSuccess = (decodedText: string) => {
    if (hasScanned || isScanning) return;
    if (!decodedText?.trim()) return;

    setHasScanned(true);
    setTimeout(() => {
      onScan(decodedText);
      stopCamera();
    }, 100);
  };

  const onScanError = (error: string) => {
    if (
      error.includes("No MultiFormat Readers") ||
      error.includes("NotFoundException") ||
      error.includes("Video stream")
    ) {
      return;
    }
    addDebugLog(`خطأ: ${error.substring(0, 50)}...`);
  };

  const startCamera = async () => {
    setCameraError(null);
    setHasScanned(false);
    addDebugLog("جاري تشغيل الكاميرا...");

    try {
      const devices = await navigator.mediaDevices.enumerateDevices();
      const videoDevices = devices.filter(
        (device) => device.kind === "videoinput",
      );

      addDebugLog(`عدد الكاميرات: ${videoDevices.length}`);

      if (videoDevices.length === 0) {
        setCameraError("لم يتم العثور على كاميرا على هذا الجهاز.");
        return;
      }

      setCameraActive(true);
    } catch (err: any) {
      console.error("Camera error:", err);
      if (err.name === "NotAllowedError") {
        setCameraError("لم يتم منح الإذن لاستخدام الكاميرا.");
      } else if (err.name === "NotFoundError") {
        setCameraError("لم يتم العثور على كاميرا على هذا الجهاز.");
      } else {
        setCameraError("تعذر تشغيل الكاميرا. يرجى المحاولة مرة أخرى.");
      }
    }
  };

  const stopCamera = () => {
    addDebugLog("إيقاف الكاميرا");
    if (scannerRef.current) {
      scannerRef.current.clear();
      scannerRef.current = null;
    }
    setCameraActive(false);
    setHasScanned(false);
    if (onClose) onClose();
  };

  if (!cameraActive) {
    return (
      <div className="text-center">
        <div className="w-80 h-80 mx-auto bg-gray-100 rounded-2xl flex items-center justify-center mb-6">
          <Camera className="w-24 h-24 text-gray-400" />
        </div>

        {cameraError && (
          <div className="mb-4 p-3 bg-red-50 text-red-600 rounded-xl text-sm flex items-center gap-2 justify-center">
            <AlertCircle className="w-5 h-5" />
            <span>{cameraError}</span>
          </div>
        )}

        <Button onClick={startCamera} variant="primary" size="lg">
          <Camera className="w-5 h-5 ml-2" />
          تشغيل الكاميرا
        </Button>
      </div>
    );
  }

  return (
    <div>
      <div className="relative mb-6">
        <div className="w-96 h-96 mx-auto overflow-hidden rounded-2xl border-4 border-[#ffbf1f] bg-black">
          <div id={containerId} className="w-full h-full"></div>
        </div>

        {isScanning && (
          <div className="absolute inset-0 bg-black/50 rounded-2xl flex items-center justify-center">
            <div className="text-center">
              <Loader2 className="w-12 h-12 text-white animate-spin mx-auto mb-2" />
              <p className="text-white">جاري المعالجة...</p>
            </div>
          </div>
        )}

        <div className="absolute bottom-2 left-0 right-0 text-center text-white text-xs bg-black/50 py-1 rounded">
          قرب رمز QR من الكاميرا
        </div>
      </div>

      {debugLog && (
        <div className="mb-3 p-2 bg-blue-50 text-blue-700 rounded-xl text-center text-sm">
          {debugLog}
        </div>
      )}

      <div className="flex gap-3 justify-center">
        <Button onClick={stopCamera} variant="outline" size="lg">
          <CameraOff className="w-5 h-5 ml-2" />
          إيقاف الكاميرا
        </Button>
      </div>
    </div>
  );
};
