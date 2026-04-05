import React from "react";

interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
  icon?: React.ReactNode;
}

export function Input({
  label,
  error,
  icon,
  className = "",
  ...props
}: InputProps) {
  return (
    <div className="w-full space-y-2">
      {label && (
        <label className="block text-sm font-medium text-foreground">
          {label}
        </label>
      )}

      <div className="relative">
        {/* عرض الأيقونة إذا وجدت */}
        {icon && (
          <div className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground">
            {icon}
          </div>
        )}

        <input
          className={`
            w-full 
            px-4 py-3 
            rounded-lg 
            border border-border 
            bg-input-background 
            text-foreground
            placeholder:text-muted-foreground
            focus:outline-none 
            focus:-ring
            focus:border-transparent 
            transition-all 
            disabled:opacity-50 
            disabled:cursor-not-allowed
            ${icon ? "pr-10" : ""} 
            ${error ? "border-destructive focus:ring-destructive" : ""} 
            ${className}
          `}
          {...props}
        />

        {error && <p className="mt-1 text-sm text-destructive">{error}</p>}
      </div>
    </div>
  );
}
