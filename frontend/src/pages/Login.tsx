import React, { useState } from "react";
import { motion } from "framer-motion";
import { Shield, Mail, Lock, Eye, EyeOff } from "lucide-react";
import { Button } from "../components/Button";
import { Input } from "../components/Input";
import { useAuth } from "../context/GlobalState";
import logo from "../assets/logo.svg";

export function Login() {
  const { state, dispatch } = useAuth();
  const [showPassword, setShowPassword] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [rememberMe, setRememberMe] = useState(false);

  //handle send form
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    console.log("محاولة تسجيل الدخول:", { email, password, rememberMe });
    // TODO: إضافة منطق تسجيل الدخول لاحقاً
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 flex items-center justify-center p-6">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="w-full max-w-md"
      >
        {/*Logo & Title */}{" "}
        <div className="text-center mb-8">
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ type: "spring", duration: 0.6 }}
            className="inline-flex items-center justify-center w-48 h-48 mb-4 rounded-full bg-white/90 border-3 border-[#ffbf1f] shadow-xl backdrop-blur-sm"
          >
            <img src={logo} />
          </motion.div>
          <h1 className="text-3xl font-bold text-white mb-2">
            تسجيل دخول الإداريين
          </h1>
        </div>
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="bg-white/10 backdrop-blur-lg rounded-2xl shadow-2xl p-8 border border-white/20"
        >
          <form onSubmit={handleSubmit} className="space-y-5">
            {/*Email*/}
            <div>
              <label className="block text-gray-300 text-sm font-medium mb-2">
                البريد الإلكتروني
              </label>
              <div className="relative">
                <Mail className="absolute right-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="email"
                  placeholder="admin@example.com"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="w-full px-4 pr-11 py-3 rounded-xl bg-white/10 border border-white/20 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f] focus:border-transparent transition-all"
                  required
                />
              </div>
            </div>

            {/* حقل كلمة المرور */}
            <div>
              <label className="block text-gray-300 text-sm font-medium mb-2">
                كلمة المرور
              </label>
              <div className="relative">
                <Lock className="absolute right-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type={showPassword ? "text" : "password"}
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full px-4 pr-11 py-3 rounded-xl bg-white/10 border border-white/20 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#ffbf1f] focus:border-transparent transition-all"
                  required
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-300"
                >
                  {showPassword ? (
                    <EyeOff className="w-5 h-5" />
                  ) : (
                    <Eye className="w-5 h-5" />
                  )}
                </button>
              </div>
            </div>

            {/* خيارات إضافية */}
            <div className="flex items-center justify-between">
              <label className="flex items-center gap-2 cursor-pointer group">
                <input
                  type="checkbox"
                  checked={rememberMe}
                  onChange={(e) => setRememberMe(e.target.checked)}
                  className="w-4 h-4 rounded border-gray-400 bg-white/10 text-[#ffbf1f] focus:ring-[#ffbf1f] focus:ring-offset-0 cursor-pointer"
                />
                <span className="text-sm text-gray-300 group-hover:text-white transition-colors">
                  تذكرني
                </span>
              </label>

              <button
                type="button"
                onClick={() => console.log("نسيت كلمة المرور")}
                className="text-sm text-[#ffbf1f] hover:text-[#e9af1c] hover:underline transition-all"
              >
                نسيت كلمة المرور؟
              </button>
            </div>

            <div className="flex flex-col items-center justify-center w-full">
              <Button
                variant="primary"
                size="lg"
                className="w-full max-w-md mx-auto"
              >
                تسجيل الدخول
              </Button>
            </div>
          </form>
        </motion.div>
      </motion.div>
    </div>
  );
}
