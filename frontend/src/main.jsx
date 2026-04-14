import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import GlobalState from "./context/GlobalState";
import { Toaster } from "react-hot-toast";
import "./index.css";
import App from "./App.jsx";

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <BrowserRouter>
      <GlobalState>
        <Toaster />
        <App />
      </GlobalState>
    </BrowserRouter>
  </StrictMode>,
);
