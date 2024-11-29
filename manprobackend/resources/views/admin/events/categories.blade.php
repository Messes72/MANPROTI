@extends('base.base')

@section('title', 'Event Categories')
@section('header', 'Event Categories')

@section('content')
<div class="bg-white shadow-sm rounded-lg">
    <!-- Header with Add Button -->
    <div class="py-6 px-4 sm:px-6 border-b border-gray-200">
        <div class="flex items-center justify-between">
            <h2 class="text-xl font-semibold text-gray-800">Categories</h2>
            <button type="button" onclick="openModal()" 
                class="px-4 py-2 bg-indigo-600 text-white text-sm font-medium rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Add Category
            </button>
        </div>
    </div>

    <!-- Categories Table -->
    <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Slug</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Events Count</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
                @forelse($categories as $category)
                    <tr id="category-{{ $category->id }}">
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                            {{ $category->name }}
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                            {{ $category->slug }}
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                {{ $category->events_count }} events
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                            <button onclick="editCategory({{ $category->id }}, '{{ $category->name }}')" 
                                class="text-indigo-600 hover:text-indigo-900">Edit</button>
                            @if($category->events_count == 0)
                                <button onclick="deleteCategory({{ $category->id }})" 
                                    class="text-red-600 hover:text-red-900">Delete</button>
                            @endif
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="4" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">
                            No categories found.
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    @if($categories->hasPages())
        <div class="px-6 py-4 border-t border-gray-200">
            {{ $categories->links() }}
        </div>
    @endif
</div>

<!-- Modal -->
<div id="categoryModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 hidden" aria-hidden="true">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white rounded-lg max-w-md w-full p-6">
            <div class="mb-4">
                <h3 class="text-lg font-medium text-gray-900" id="modalTitle">Add Category</h3>
            </div>

            <form id="categoryForm" onsubmit="saveCategory(event)" class="space-y-4">
                @csrf
                <input type="hidden" id="categoryId">
                
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
                    <input type="text" name="name" id="name" required
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                    <p class="mt-1 text-sm text-red-600 hidden" id="nameError"></p>
                </div>

                <div class="mt-5 flex justify-end space-x-3">
                    <button type="button" onclick="closeModal()"
                        class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Cancel
                    </button>
                    <button type="submit"
                        class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Save
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

@push('scripts')
<script>
    const modal = document.getElementById('categoryModal');
    const form = document.getElementById('categoryForm');
    const nameInput = document.getElementById('name');
    const categoryIdInput = document.getElementById('categoryId');
    const modalTitle = document.getElementById('modalTitle');
    const nameError = document.getElementById('nameError');

    function openModal() {
        modal.classList.remove('hidden');
        modalTitle.textContent = 'Add Category';
        form.reset();
        categoryIdInput.value = '';
        nameError.classList.add('hidden');
    }

    function closeModal() {
        modal.classList.add('hidden');
        form.reset();
        nameError.classList.add('hidden');
    }

    function editCategory(id, name) {
        modalTitle.textContent = 'Edit Category';
        categoryIdInput.value = id;
        nameInput.value = name;
        nameError.classList.add('hidden');
        modal.classList.remove('hidden');
    }

    async function saveCategory(event) {
        event.preventDefault();
        const id = categoryIdInput.value;
        const isEdit = !!id;
        
        try {
            const response = await fetch(
                isEdit 
                    ? `{{ url('admin/events/categories') }}/${id}`
                    : '{{ route('admin.events.categories.store') }}',
                {
                    method: isEdit ? 'PUT' : 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '{{ csrf_token() }}'
                    },
                    body: JSON.stringify({
                        name: nameInput.value
                    })
                }
            );

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.message || 'Something went wrong');
            }

            // Success - refresh the page
            window.location.reload();
        } catch (error) {
            nameError.textContent = error.message;
            nameError.classList.remove('hidden');
        }
    }

    async function deleteCategory(id) {
        if (!confirm('Are you sure you want to delete this category?')) {
            return;
        }

        try {
            const response = await fetch(`{{ url('admin/events/categories') }}/${id}`, {
                method: 'DELETE',
                headers: {
                    'X-CSRF-TOKEN': '{{ csrf_token() }}'
                }
            });

            if (!response.ok) {
                const data = await response.json();
                throw new Error(data.message || 'Failed to delete category');
            }

            // Remove the row from the table
            document.getElementById(`category-${id}`).remove();
        } catch (error) {
            alert(error.message);
        }
    }

    // Close modal when clicking outside
    modal.addEventListener('click', function(event) {
        if (event.target === modal) {
            closeModal();
        }
    });

    // Close modal with escape key
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape' && !modal.classList.contains('hidden')) {
            closeModal();
        }
    });
</script>
@endpush
@endsection 