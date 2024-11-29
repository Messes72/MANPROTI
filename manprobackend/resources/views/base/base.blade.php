<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title') - Admin Panel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Add Heroicons (Optional but recommended for icons) -->
    <script src="https://unpkg.com/@heroicons/v2@1.0.0/24/outline/index.min.js"></script>
</head>
<body class="bg-gray-100">
    @auth
        <div class="min-h-screen flex">
            <!-- Sidebar -->
            <div class="bg-indigo-800 text-white w-64 py-6 flex flex-col">
                <div class="px-6 mb-8">
                    <h1 class="text-2xl font-bold">Admin Panel</h1>
                </div>
                
                <!-- Navigation -->
                <nav class="flex-1 px-4 space-y-2">
                    <a href="{{ route('admin.dashboard') }}" 
                        class="block px-4 py-2 rounded-lg hover:bg-indigo-700 {{ request()->routeIs('admin.dashboard') ? 'bg-indigo-900' : '' }}">
                        Dashboard
                    </a>

                    <!-- Events Management -->
                    <div class="space-y-2">
                        <p class="px-4 text-xs text-indigo-300 uppercase tracking-wider mt-4">Events</p>
                        <a href="{{ route('admin.events.index') }}" 
                            class="block px-4 py-2 rounded-lg hover:bg-indigo-700 {{ request()->routeIs('admin.events.*') ? 'bg-indigo-900' : '' }}">
                            All Events
                        </a>
                        <a href="{{ route('admin.events.categories') }}" 
                            class="block px-4 py-2 rounded-lg hover:bg-indigo-700 {{ request()->routeIs('admin.events.categories') ? 'bg-indigo-900' : '' }}">
                            Event Categories
                        </a>
                        <a href="{{ route('admin.events.registrations') }}" 
                            class="block px-4 py-2 rounded-lg hover:bg-indigo-700 {{ request()->routeIs('admin.events.registrations') ? 'bg-indigo-900' : '' }}">
                            Event Registrations
                        </a>
                    </div>

                    <!-- Articles Management -->
                    <div class="space-y-2">
                        <p class="px-4 text-xs text-indigo-300 uppercase tracking-wider mt-4">Content</p>
                        <a href="#" class="block px-4 py-2 rounded-lg hover:bg-indigo-700">
                            Articles
                        </a>
                    </div>

                    <!-- Donations Management -->
                    <div class="space-y-2">
                        <p class="px-4 text-xs text-indigo-300 uppercase tracking-wider mt-4">Donations</p>
                        <a href="#" class="block px-4 py-2 rounded-lg hover:bg-indigo-700">
                            All Donations
                        </a>
                        <a href="#" class="block px-4 py-2 rounded-lg hover:bg-indigo-700">
                            Donation Types
                        </a>
                        <a href="#" class="block px-4 py-2 rounded-lg hover:bg-indigo-700">
                            Shipping Methods
                        </a>
                    </div>

                    <!-- Settings -->
                    <div class="space-y-2">
                        <p class="px-4 text-xs text-indigo-300 uppercase tracking-wider mt-4">Settings</p>
                        <a href="#" class="block px-4 py-2 rounded-lg hover:bg-indigo-700">
                            Contact Info
                        </a>
                        <a href="#" class="block px-4 py-2 rounded-lg hover:bg-indigo-700">
                            User Management
                        </a>
                    </div>
                </nav>

                <!-- User Menu -->
                <div class="px-6 py-4 border-t border-indigo-700">
                    <div class="flex items-center">
                        <div class="flex-1">
                            <p class="text-sm">{{ Auth::user()->nama_lengkap }}</p>
                            <p class="text-xs text-indigo-300">Administrator</p>
                        </div>
                        <form action="{{ route('admin.logout') }}" method="POST" class="inline">
                            @csrf
                            <button type="submit" class="text-sm text-indigo-300 hover:text-white">
                                Logout
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="flex-1">
                <!-- Top Navigation -->
                <div class="bg-white shadow-sm">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="flex justify-between h-16">
                            <div class="flex items-center">
                                <h2 class="text-2xl font-semibold text-gray-800">@yield('header', 'Dashboard')</h2>
                            </div>
                            <div class="flex items-center">
                                <!-- Add any top navigation items here -->
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Page Content -->
                <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
                    @if(session('success'))
                        <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">{{ session('success') }}</span>
                        </div>
                    @endif

                    @if(session('error'))
                        <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">{{ session('error') }}</span>
                        </div>
                    @endif

                    @yield('content')
                </main>
            </div>
        </div>
    @else
        @yield('content')
    @endauth

    <!-- Scripts -->
    @stack('scripts')
</body>
</html>
