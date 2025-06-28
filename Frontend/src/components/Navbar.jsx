import { Link } from "react-router-dom";
import { Plus } from "lucide-react";

const Navbar = () => {
  return (
    <header className="bg-base-300 border-b border-base-content/10">
      <div className="mx-auto max-w-6xl p-4">
        <div className="flex items-center justify-between">
          <Link to="/" className="text-lg font-bold">My Notes App</Link>
          <Link to="/create" className="btn btn-primary flex items-center gap-2">
            <Plus className="w-5 h-5" />
            New Note
          </Link>
        </div>
      </div>
    </header>
  );
};

export default Navbar;
