// src/components/Button.tsx
import React from "react";
import { motion } from "motion/react";
interface ButtonProps {
  children: React.ReactNode;
  variant?:
    | "primary"
    | "secondary"
    | "outline"
    | "ghost"
    | "success"
    | "danger";
  size?: "sm" | "md" | "lg";
  className?: string;
}

export function Button({
  variant = "primary",
  size = "md",
  children,
  className = "",
  ...props // استقبال باقي الـ props
}: ButtonProps) {
  const baseClasses = "rounded-lg font-medium transition-all duration-200";

  const variantClasses = {
    primary: "bg-primary text-primary-foreground hover:bg-accent",
    secondary: "bg-secondary text-secondary-foreground hover:bg-muted",
    outline:
      "border-2 border-primary text-primary hover:bg-primary hover:text-primary-foreground",
    ghost: "text-foreground hover:bg-muted active:scale-95",
  };

  const sizeClasses = {
    sm: "px-3 py-1.5 text-sm",
    md: "px-4 py-2.5",
    lg: "px-6 py-3.5 text-lg",
  };

  return (
    <motion.button
      whileTap={{ scale: 0.95 }}
      className={`
        ${baseClasses}
        ${variantClasses[variant as keyof typeof variantClasses]}
        ${sizeClasses[size]}
        ${className}
      `}
      {...props}
    >
      {children}
    </motion.button>
  );
}
