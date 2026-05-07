import React, { useState } from "react";
import { motion } from "motion/react";
import { Button } from "../../../components/Button";
import { Input } from "../../../components/Input";
import { Plus, X } from "lucide-react";
import toast from "react-hot-toast";
import { CreatePackageData } from "../../../APIMethod/packages";

export function AddNewPackage({
  onClose,
  onAddPackage,
}: {
  onClose: () => void;
  onAddPackage: (packagesData: CreatePackageData) => void;
}) {
  const [formData, setFormData] = useState({
    name: "",
    price: "",
    hour: "",
    duration_days: "",
  });

  const validateForm = () => {
    if (!formData.name.trim()) {
      toast.error(" Enter The Package Name");
      return false;
    }
    if (!formData.price || Number(formData.price) <= 0) {
      toast.error("Enter Correct Price ");
      return false;
    }
    if (!formData.hour || Number(formData.hour) <= 0) {
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

    const packageData: CreatePackageData = {
      name: formData.name,
      price: Number(formData.price).toFixed(3),
      hours: Number(formData.hour),
      duration_days: Number(formData.duration_days),
    };

    onAddPackage(packageData);
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-6"
      onClick={onClose}
    >
      <motion.div
        initial={{ scale: 0.95, opacity: 0, y: 20 }}
        animate={{ scale: 1, opacity: 1, y: 0 }}
        exit={{ scale: 0.95, opacity: 0, y: 20 }}
        onClick={(e) => e.stopPropagation()}
        className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto"
      >
        {/* Header */}
        <div className="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between">
          <h2 className="text-2xl text-gray-900">إضافة باقة جديدة</h2>
          <button
            onClick={onClose}
            className="w-10 h-10 rounded-xl hover:bg-gray-100 flex items-center justify-center transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Form */}
        <div className="p-6 space-y-5">
          <Input
            label="اسم الباقة"
            placeholder="مثال: الباقة الأسبوعية الذهبية"
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
          />

          <div className="grid grid-cols-2 gap-6">
            <Input
              label="السعر (ليرة سورية)"
              type="number"
              placeholder="150"
              value={formData.price}
              onChange={(e) =>
                setFormData({ ...formData, price: e.target.value })
              }
            />

            <Input
              label="عدد الساعات"
              type="number"
              placeholder="80"
              value={formData.hour}
              onChange={(e) =>
                setFormData({ ...formData, hour: e.target.value })
              }
            />
          </div>

          <div className="grid grid-cols-1 gap-6">
            <Input
              label="مدة الصلاحية (يوم)"
              type="number"
              placeholder="30"
              value={formData.duration_days}
              onChange={(e) =>
                setFormData({ ...formData, duration_days: e.target.value })
              }
            />
          </div>

          {/* Actions */}
          <div className="flex gap-3 pt-4">
            <Button variant="outline" className="flex-1" onClick={onClose}>
              إلغاء
            </Button>
            <Button variant="primary" className="flex-1" onClick={handleSubmit}>
              <Plus className="w-5 h-5 ml-2" />
              إضافة الباقة
            </Button>
          </div>
        </div>
      </motion.div>
    </motion.div>
  );
}
