import React, { useState } from "react";
import { motion } from "motion/react";
import {
  ArrowRight,
  User,
  Mail,
  Phone,
  Lock,
  Bell,
  Clock,
  Calendar,
  Edit,
  Save,
  Eye,
  EyeOff,
} from "lucide-react";
import { Button } from "../../components/Button";
import { Input } from "../../components/Input";
import { useNavigate } from "react-router-dom";

export function ReceptionistProfile() {
  const navigate = useNavigate();

  const [isEditing, setIsEditing] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [activeTab, setActiveTab] = useState<
    "profile" | "security" | "notifications"
  >("profile");

  const [profileData, setProfileData] = useState({
    name: "أحمد الخالدي",
    email: "ahmed.alkhalidi@studyhub.com",
    phone: "0501234567",
    employeeId: "EMP-2024-001",
    position: "موظف استقبال",
    joinDate: "2024-01-15",
    workingHours: "08:00 - 17:00",
  });

  const [passwordData, setPasswordData] = useState({
    currentPassword: "",
    newPassword: "",
    confirmPassword: "",
  });

  const [notifications, setNotifications] = useState({
    checkIn: true,
    checkOut: true,
    tableFull: true,
    maintenance: false,
    emailNotifications: true,
  });

  const handleBack = () => {
    navigate(-1);
  };

  const handleSaveProfile = () => {
    setIsEditing(false);
    // حفظ التغييرات
  };

  const handleChangePassword = () => {
    // تغيير كلمة المرور
    setPasswordData({
      currentPassword: "",
      newPassword: "",
      confirmPassword: "",
    });
  };

  const stats = [
    {
      label: "تسجيلات اليوم",
      value: "67",
      icon: User,
      color: "from-[#ffbf1f] to-[#e6ac1c]",
    },
    {
      label: "مغادرات اليوم",
      value: "52",
      icon: User,
      color: "from-[#034363] to-[#045a85]",
    },
    {
      label: "إجمالي هذا الشهر",
      value: "1,245",
      icon: Calendar,
      color: "from-[#10B981] to-[#059669]",
    },
    {
      label: "ساعات العمل",
      value: "156",
      icon: Clock,
      color: "from-[#f0f8fc] to-[#d9eef7]",
    },
  ];

  return (
    <div className="min-h-screen bg-linear-to-br from-blue-50 to-indigo-50">
      {/* Header */}
      <div className="bg-linear-to-br from-[#034363] to-[#045a85] text-white p-6 shadow-lg">
        <div className="max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-6">
            <button
              onClick={handleBack}
              className="p-2 hover:bg-white/10 rounded-xl transition-colors"
            >
              <ArrowRight className="w-6 h-6" />
            </button>
            <div>
              <h1 className="text-3xl mb-1">الملف الشخصي</h1>
              <p className="text-blue-100">إدارة معلوماتك الشخصية وإعداداتك</p>
            </div>
          </div>

          {/* Profile Card */}
          <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-6">
            <div className="flex items-center gap-6">
              <div className="w-24 h-24 bg-linear-to-br from-[#ffbf1f] to-[#e6ac1c] rounded-2xl flex items-center justify-center text-white text-3xl font-bold shadow-lg">
                {profileData.name.charAt(0)}
              </div>
              <div className="flex-1">
                <h2 className="text-2xl font-bold mb-1">{profileData.name}</h2>
                <p className="text-blue-100 mb-2">{profileData.position}</p>
                <div className="flex items-center gap-4 text-sm">
                  <span className="flex items-center gap-1">
                    <User className="w-4 h-4" />
                    {profileData.employeeId}
                  </span>
                  <span className="flex items-center gap-1">
                    <Calendar className="w-4 h-4" />
                    انضم في {profileData.joinDate}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto p-6">
        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
          {stats.map((stat, index) => {
            const Icon = stat.icon;
            return (
              <motion.div
                key={index}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
                className={`bg-linear-to-br ${stat.color} rounded-2xl p-6 shadow-lg`}
              >
                <div className="flex items-center justify-between mb-3">
                  <Icon
                    className={`w-6 h-6 ${stat.color.includes("f0f8fc") ? "text-[#034363]" : "text-white"}`}
                  />
                  <span
                    className={`text-3xl font-bold ${stat.color.includes("f0f8fc") ? "text-[#034363]" : "text-white"}`}
                  >
                    {stat.value}
                  </span>
                </div>
                <p
                  className={`text-sm ${stat.color.includes("f0f8fc") ? "text-[#034363]" : "text-white"} opacity-90`}
                >
                  {stat.label}
                </p>
              </motion.div>
            );
          })}
        </div>

        {/* Tabs */}
        <div className="bg-white rounded-2xl shadow-lg mb-6">
          <div className="flex border-b border-gray-200">
            <button
              onClick={() => setActiveTab("profile")}
              className={`flex-1 px-6 py-4 text-center transition-all ${
                activeTab === "profile"
                  ? "border-b-2 border-[#ffbf1f] text-[#034363] font-semibold"
                  : "text-gray-600 hover:text-gray-900"
              }`}
            >
              <User className="w-5 h-5 inline ml-2" />
              المعلومات الشخصية
            </button>
            <button
              onClick={() => setActiveTab("security")}
              className={`flex-1 px-6 py-4 text-center transition-all ${
                activeTab === "security"
                  ? "border-b-2 border-[#ffbf1f] text-[#034363] font-semibold"
                  : "text-gray-600 hover:text-gray-900"
              }`}
            >
              <Lock className="w-5 h-5 inline ml-2" />
              الأمان
            </button>
            <button
              onClick={() => setActiveTab("notifications")}
              className={`flex-1 px-6 py-4 text-center transition-all ${
                activeTab === "notifications"
                  ? "border-b-2 border-[#ffbf1f] text-[#034363] font-semibold"
                  : "text-gray-600 hover:text-gray-900"
              }`}
            >
              <Bell className="w-5 h-5 inline ml-2" />
              الإشعارات
            </button>
          </div>

          <div className="p-6">
            {/* Profile Tab */}
            {activeTab === "profile" && (
              <div className="space-y-6">
                <div className="flex items-center justify-between mb-6">
                  <h3 className="text-xl font-bold text-gray-900">
                    البيانات الأساسية
                  </h3>
                  {!isEditing ? (
                    <Button
                      onClick={() => setIsEditing(true)}
                      variant="outline"
                    >
                      <Edit className="w-4 h-4 ml-2" />
                      تعديل
                    </Button>
                  ) : (
                    <div className="flex gap-2">
                      <Button onClick={handleSaveProfile} variant="primary">
                        <Save className="w-4 h-4 ml-2" />
                        حفظ
                      </Button>
                      <Button
                        onClick={() => setIsEditing(false)}
                        variant="outline"
                      >
                        إلغاء
                      </Button>
                    </div>
                  )}
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <Input
                    label="الاسم الكامل"
                    value={profileData.name}
                    onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                      setProfileData({ ...profileData, name: e.target.value })
                    }
                    disabled={!isEditing}
                    icon={<User className="w-5 h-5" />}
                  />
                  <Input
                    label="رقم الموظف"
                    value={profileData.employeeId}
                    disabled
                    icon={<User className="w-5 h-5" />}
                  />
                  <Input
                    label="البريد الإلكتروني"
                    type="email"
                    value={profileData.email}
                    onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                      setProfileData({ ...profileData, email: e.target.value })
                    }
                    disabled={!isEditing}
                    icon={<Mail className="w-5 h-5" />}
                  />
                  <Input
                    label="رقم الجوال"
                    type="tel"
                    value={profileData.phone}
                    onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                      setProfileData({ ...profileData, phone: e.target.value })
                    }
                    disabled={!isEditing}
                    icon={<Phone className="w-5 h-5" />}
                  />
                  <Input
                    label="المسمى الوظيفي"
                    value={profileData.position}
                    disabled
                  />
                  <Input
                    label="ساعات العمل"
                    value={profileData.workingHours}
                    disabled
                    icon={<Clock className="w-5 h-5" />}
                  />
                </div>
              </div>
            )}

            {/* Security Tab */}
            {activeTab === "security" && (
              <div className="space-y-6">
                <h3 className="text-xl font-bold text-gray-900 mb-6">
                  تغيير كلمة المرور
                </h3>

                <div className="space-y-4">
                  <div className="relative">
                    <Input
                      label="كلمة المرور الحالية"
                      type={showPassword ? "text" : "password"}
                      value={passwordData.currentPassword}
                      onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                        setPasswordData({
                          ...passwordData,
                          currentPassword: e.target.value,
                        })
                      }
                      icon={<Lock className="w-5 h-5" />}
                    />
                    <button
                      onClick={() => setShowPassword(!showPassword)}
                      className="absolute left-3 top-10.5 text-gray-400 hover:text-gray-600"
                    >
                      {showPassword ? (
                        <EyeOff className="w-5 h-5" />
                      ) : (
                        <Eye className="w-5 h-5" />
                      )}
                    </button>
                  </div>

                  <Input
                    label="كلمة المرور الجديدة"
                    type={showPassword ? "text" : "password"}
                    value={passwordData.newPassword}
                    onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                      setPasswordData({
                        ...passwordData,
                        newPassword: e.target.value,
                      })
                    }
                    icon={<Lock className="w-5 h-5" />}
                  />

                  <Input
                    label="تأكيد كلمة المرور الجديدة"
                    type={showPassword ? "text" : "password"}
                    value={passwordData.confirmPassword}
                    onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                      setPasswordData({
                        ...passwordData,
                        confirmPassword: e.target.value,
                      })
                    }
                    icon={<Lock className="w-5 h-5" />}
                  />

                  <Button
                    onClick={handleChangePassword}
                    variant="primary"
                    className="w-full"
                  >
                    <Lock className="w-5 h-5 ml-2" />
                    تحديث كلمة المرور
                  </Button>
                </div>

                <div className="mt-8 p-4 bg-blue-50 rounded-xl">
                  <h4 className="font-semibold text-[#034363] mb-2">
                    نصائح لكلمة مرور قوية
                  </h4>
                  <ul className="space-y-1 text-sm text-gray-700">
                    <li>• استخدم 8 أحرف على الأقل</li>
                    <li>• اجمع بين الأحرف الكبيرة والصغيرة</li>
                    <li>• أضف أرقام ورموز خاصة</li>
                    <li>• تجنب استخدام معلومات شخصية</li>
                  </ul>
                </div>
              </div>
            )}

            {/* Notifications Tab */}
            {activeTab === "notifications" && (
              <div className="space-y-6">
                <h3 className="text-xl font-bold text-gray-900 mb-6">
                  إعدادات الإشعارات
                </h3>

                <div className="space-y-4">
                  {[
                    {
                      key: "checkIn",
                      label: "تسجيل دخول الطلاب",
                      description: "الحصول على إشعار عند تسجيل دخول طالب",
                    },
                    {
                      key: "checkOut",
                      label: "تسجيل خروج الطلاب",
                      description: "الحصول على إشعار عند تسجيل خروج طالب",
                    },
                    {
                      key: "tableFull",
                      label: "امتلاء الطاولات",
                      description: "تنبيه عند وصول الطاولات لنسبة إشغال عالية",
                    },
                    {
                      key: "maintenance",
                      label: "صيانة الطاولات",
                      description: "إشعار عند الحاجة لصيانة طاولة",
                    },
                    {
                      key: "emailNotifications",
                      label: "إشعارات البريد الإلكتروني",
                      description: "استلام الإشعارات عبر البريد الإلكتروني",
                    },
                  ].map((item) => (
                    <div
                      key={item.key}
                      className="flex items-center justify-between p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors"
                    >
                      <div className="flex-1">
                        <h4 className="font-semibold text-gray-900 mb-1">
                          {item.label}
                        </h4>
                        <p className="text-sm text-gray-600">
                          {item.description}
                        </p>
                      </div>
                      <button
                        onClick={() =>
                          setNotifications({
                            ...notifications,
                            [item.key]:
                              !notifications[
                                item.key as keyof typeof notifications
                              ],
                          })
                        }
                        className={`relative w-14 h-7 rounded-full transition-colors ${
                          notifications[item.key as keyof typeof notifications]
                            ? "bg-[#ffbf1f]"
                            : "bg-gray-300"
                        }`}
                      >
                        <span
                          className={`absolute top-0.5 w-6 h-6 bg-white rounded-full shadow-md transition-transform ${
                            notifications[
                              item.key as keyof typeof notifications
                            ]
                              ? "translate-x-7"
                              : "translate-x-0.5"
                          }`}
                        />
                      </button>
                    </div>
                  ))}
                </div>

                <Button variant="primary" className="w-full">
                  <Save className="w-5 h-5 ml-2" />
                  حفظ الإعدادات
                </Button>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
