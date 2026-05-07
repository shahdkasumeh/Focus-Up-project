import React, { useState, useEffect } from "react";
import { motion } from "motion/react";
import { Button } from "../../../components/Button";
import { Input } from "../../../components/Input";
import { Save, X } from "lucide-react";
import toast from "react-hot-toast";
import { UpdatePackageData } from "../../../APIMethod/packages";

interface UpdatePackageProps {
  package: {
    id: number;
    name: string;
    hours: number;
    price: string;
    duration_days: number;
    is_active?: number | string;
  };
  onClose: () => void;
  onUpdatePackage: (packageData: UpdatePackageData, packageId: number) => void;
}

export function UpdatePackage({
  package: pkg,
  onClose,
  onUpdatePackage,
}: UpdatePackageProps) {
  const [formData, setFormData] = useState({
    id: "",
    name: "",
    price: "",
    hours: "",
    duration_days: "",
    is_active: "1",
  });
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    if (pkg) {
      setFormData({
        id: pkg.id?.toString() || "",
        name: pkg.name || "",
        price: pkg.price?.toString() || "",
        hours: pkg.hours?.toString() || "",
        duration_days: pkg.duration_days?.toString() || "",
        is_active: pkg.is_active?.toString() || "1",
      });
    }
  }, [pkg]);

  const validateForm = () => {
    if (!formData.name.trim()) {
      toast.error("Enter The Package Name");
      return false;
    }
    if (!formData.price || Number(formData.price) <= 0) {
      toast.error("Enter Correct Price");
      return false;
    }
    if (!formData.hours || Number(formData.hours) <= 0) {
      toast.error("Enter Correct Hours Number");
      return false;
    }
    if (!formData.duration_days || Number(formData.duration_days) <= 0) {
      toast.error("Enter Correct Validity Period");
      return false;
    }
    return true;
  };

  const handleSubmit = () => {
    if (!validateForm()) return;

    const updateData: UpdatePackageData = {
      name: formData.name,
      price: Number(formData.price).toFixed(3),
      hours: Number(formData.hours),
      duration_days: Number(formData.duration_days),
      is_active: formData.is_active,
    };
    onUpdatePackage(updateData, Number(formData.id));
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4"
      onClick={onClose}
    >
      <motion.div
        initial={{ scale: 0.95, opacity: 0, y: 20 }}
        animate={{ scale: 1, opacity: 1, y: 0 }}
        exit={{ scale: 0.95, opacity: 0, y: 20 }}
        onClick={(e) => e.stopPropagation()}
        className="bg-white rounded-3xl shadow-2xl max-w-md w-full overflow-hidden"
      >
        {/* Header */}
        <div className="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
          <h2 className="text-2xl text-gray-900">تعديل الباقة</h2>
          <button
            onClick={onClose}
            className="w-10 h-10 rounded-xl hover:bg-gray-100 flex items-center justify-center transition-colors"
            disabled={isLoading}
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 space-y-4">
          <Input
            label="اسم الباقة"
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
            disabled={isLoading}
          />

          <Input
            label="السعر (ليرة سورية)"
            type="number"
            value={formData.price}
            onChange={(e) =>
              setFormData({ ...formData, price: e.target.value })
            }
            disabled={isLoading}
          />

          <Input
            label="عدد الساعات"
            type="number"
            value={formData.hours}
            onChange={(e) =>
              setFormData({ ...formData, hours: e.target.value })
            }
            disabled={isLoading}
          />

          <Input
            label="مدة الصلاحية (يوم)"
            type="number"
            value={formData.duration_days}
            onChange={(e) =>
              setFormData({ ...formData, duration_days: e.target.value })
            }
            disabled={isLoading}
          />

          <div className="space-y-1">
            <label className="block text-sm font-medium text-gray-700">
              حالة الباقة
            </label>
            <select
              value={formData.is_active}
              onChange={(e) =>
                setFormData({ ...formData, is_active: e.target.value })
              }
              className="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:border-[#ffbf1f] focus:outline-none"
              disabled={isLoading}
            >
              <option value="1">نشطة</option>
              <option value="0">غير نشطة</option>
            </select>
          </div>
        </div>

        {/* Actions */}
        <div className="flex gap-3 p-6 pt-0">
          <Button
            variant="outline"
            className="flex-1"
            onClick={onClose}
            disabled={isLoading}
          >
            إلغاء
          </Button>
          <Button
            variant="primary"
            className="flex-1 gap-2"
            onClick={handleSubmit}
            disabled={isLoading}
          >
            {isLoading ? (
              <>
                <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                جاري التعديل...
              </>
            ) : (
              <>
                <Save className="w-4 h-4" />
                تعديل
              </>
            )}
          </Button>
        </div>
      </motion.div>
    </motion.div>
  );
}
