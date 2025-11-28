<script lang="ts">
import { defineComponent, ref } from "vue";
import AutoComplete from "primevue/autocomplete";
import FloatLabel from "primevue/floatlabel";
import InputGroup from "primevue/inputgroup";
import InputGroupAddon from "primevue/inputgroupaddon";
import InputNumber from "primevue/inputnumber";
const loading = ref(false);
const error = ref("");
const number = ref(null);

const getDescription = async () => {
  // Reset error and set loading state
  error.value = "";
  loading.value = true;

  try {
    // Fetch user id from session
    const sessionStr = localStorage.getItem("session");
    const session = JSON.parse(sessionStr || "{}");

    const response: any = await $fetch("/api/finance/description", {
      method: "POST",
      body: {
        user_id: session.user?.id,
      },
    });

    console.log("API Response:", response);

    if (response?.data) {
      return response.data;
    }
  } catch (err: any) {
    console.error("Fetch error:", err);
    error.value = err.message || "Failed to fetch descriptions";
  } finally {
    loading.value = false;
  }
};

export default defineComponent({
  name: "AddTransaction",
  components: {
    AutoComplete,
    FloatLabel,
    InputGroup,
    InputGroupAddon,
    InputNumber,
  },
  setup() {
    const description = ref("");
    const number = ref<number | null>(null);

    // Store all descriptions from the database
    const descriptionList = ref<{ description: string }[]>([]);

    // Suggestions shown by the AutoComplete
    const filteredDescriptions = ref<{ name: string }[]>([]);

    // Fetch descriptions on component mount
    const loadDescriptions = async () => {
      const data = await getDescription();
      if (data && Array.isArray(data)) {
        // Transform to match the format expected by AutoComplete
        descriptionList.value = data;
      }
    };

    loadDescriptions();
    function search(event: { query: string }) {
      const query =
        event && event.query ? event.query.trim().toLowerCase() : "";
      if (!query) {
        filteredDescriptions.value = [];
        return;
      }

      // Filter descriptions based on user input
      filteredDescriptions.value = descriptionList.value
        .filter((item) => item.description.toLowerCase().includes(query))
        .map((item) => ({ name: item.description }));
    }

    return { description, filteredDescriptions, search, number };
  },
});
</script>

<template>
  <main>
    <div class="transaction-box">
      <div class="header">
        <div class="icon-wrapper">
          <span class="header-icon">💸</span>
        </div>
        <h2 class="add-Title">Add New Transaction</h2>
      </div>
      <AutoComplete
        v-model="description"
        inputId="description_input"
        optionLabel="name"
        :suggestions="filteredDescriptions"
        placeholder="Description"
        @complete="search"
      />

      <InputGroup>
        <InputGroupAddon>$</InputGroupAddon>
        <InputNumber v-model="number" placeholder="Price" />
        <InputGroupAddon>.00</InputGroupAddon>
      </InputGroup>
    </div>
  </main>
</template>

<style scoped>
main {
  margin-top: 2rem;
}

/* ======= AUTOCOMPLETE STYLING ======= */
/* Input field styling */
:deep(.p-autocomplete) {
  width: 100%;
}

:deep(.p-autocomplete-input) {
  padding: 0.875rem 1.125rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 0.75rem;
  color: #386641;
  font-size: 1em;
  font-weight: 500;
  background: rgba(255, 255, 255, 0.4);
  transition: all 0.2s ease-in-out;
  outline: none;
  width: 100%;
  box-sizing: border-box;
}

:deep(.p-autocomplete-input:hover) {
  border-color: rgba(56, 102, 65, 0.2);
}

:deep(.p-autocomplete-input:focus) {
  border-color: rgba(167, 201, 87, 0.6);
  box-shadow: 0 0 0 3px rgba(167, 201, 87, 0.1);
  background: rgba(255, 255, 255, 0.6);
}

:deep(.p-autocomplete-input::placeholder) {
  color: rgba(56, 102, 65, 0.4);
  font-weight: 400;
}

:deep(.p-autocomplete-input:disabled) {
  background: rgba(255, 255, 255, 0.2);
  color: rgba(56, 102, 65, 0.4);
  cursor: not-allowed;
}

/* ======= INPUT GROUP STYLING ======= */
:deep(.p-inputgroup) {
  margin-top: 1.5rem;
}

:deep(.p-inputnumber-input) {
  padding: 0.875rem 1.125rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #386641;
  font-size: 1em;
  font-weight: 500;
  background: rgba(255, 255, 255, 0.4);
  transition: all 0.2s ease-in-out;
  outline: none;
  border-radius: 0;
}

:deep(.p-inputnumber-input:hover) {
  border-color: rgba(56, 102, 65, 0.2);
}

:deep(.p-inputnumber-input:focus) {
  border-color: rgba(167, 201, 87, 0.6);
  box-shadow: 0 0 0 3px rgba(167, 201, 87, 0.1);
  background: rgba(255, 255, 255, 0.6);
}

:deep(.p-inputnumber-input::placeholder) {
  color: rgba(56, 102, 65, 0.4);
  font-weight: 400;
}

:deep(.p-inputgroupaddon) {
  --p-inputgroup-addon-background: rgba(167, 201, 87, 0.2);
  --p-inputgroup-addon-border-color: rgba(255, 255, 255, 0.1);
  --p-inputgroup-addon-color: #386641;
  --p-inputgroup-addon-padding: 0.875rem 1rem;
  font-weight: 600;
  font-size: 1em;
  transition: all 0.2s ease-in-out;
}

:deep(.p-inputgroup-addon:first-child) {
  border-top-left-radius: 0.75rem;
  border-bottom-left-radius: 0.75rem;
  border-right: none;
}

:deep(.p-inputgroup-addon:last-child) {
  border-top-right-radius: 0.75rem;
  border-bottom-right-radius: 0.75rem;
  border-left: none;
}

:deep(.p-inputnumber) {
  flex: 1;
}

:deep(.p-inputgroup:hover .p-inputnumber-input) {
  border-color: rgba(56, 102, 65, 0.2);
}

:deep(.p-inputgroup:hover .p-inputgroupaddon) {
  --p-inputgroup-addon-background: rgba(167, 201, 87, 0.3);
  --p-inputgroup-addon-border-color: rgba(56, 102, 65, 0.2);
}
</style>

<!-- Global styles for dropdown panel (it's portaled to body) -->
<style>
/* ======= AUTOCOMPLETE DROPDOWN STYLING ======= */
/* Dropdown panel container */
.p-autocomplete-overlay {
  background: rgba(255, 255, 255, 0.95) !important;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(167, 201, 87, 0.2) !important;
  border-radius: 0.75rem !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4) !important;
  margin-top: 0.5rem;
}

/* List container and list */
.p-autocomplete-list-container {
  overflow: auto;
  max-height: 300px;
}

.p-autocomplete-list {
  padding: 0.5rem !important;
  list-style: none;
  margin: 0 !important;
}

/* Dropdown options */
.p-autocomplete-option {
  padding: 0.75rem 1rem !important;
  margin: 0.25rem 0;
  border-radius: 0.5rem !important;
  color: #386641 !important;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.p-autocomplete-option:hover {
  background: rgba(167, 201, 87, 0.15) !important;
  color: #386641 !important;
}

.p-autocomplete-option:focus,
.p-autocomplete-option.p-focus {
  background: rgba(167, 201, 87, 0.2) !important;
  color: #386641 !important;
  outline: none;
}

.p-autocomplete-option.p-selected {
  background: rgba(167, 201, 87, 0.3) !important;
  color: #386641 !important;
  font-weight: 600;
}

.p-autocomplete-option.p-selected:focus {
  background: rgba(167, 201, 87, 0.4) !important;
  color: #386641 !important;
}

/* Empty message when no results */
.p-autocomplete-empty-message {
  padding: 1rem !important;
  color: rgba(56, 102, 65, 0.6) !important;
  text-align: center;
  font-style: italic;
}
</style>

<style scoped>
.transaction-box {
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(10px);
  color: #386641;
  padding: 2rem;
  border-radius: 1.25rem;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.05);
  width: 100%;
  box-sizing: border-box;
  border: 1px solid rgba(167, 201, 87, 0.2);
}
.transaction-box:hover {
  box-shadow: 0 12px 45px rgba(56, 102, 65, 0.15),
    inset 0 1px 0 rgba(255, 255, 255, 0.5);
  border-color: rgba(167, 201, 87, 0.4);
}

/* ======= ADD TRANSACTION HEADER ======= */

.header {
  display: flex;
  align-items: center;
  flex-direction: column;
  margin-bottom: 2rem;
  padding-bottom: 1.5rem;
  border-bottom: 2px solid rgba(167, 201, 87, 0.2);
}
.icon-wrapper {
  display: inline-flex;
  justify-content: center;
  align-items: center;
  width: 60px;
  height: 60px;
  background: linear-gradient(
    135deg,
    rgba(167, 201, 87, 0.2),
    rgba(106, 153, 78, 0.3)
  );
  border-radius: 50%;
  margin-bottom: 1rem;
  box-shadow: 0 4px 15px rgba(167, 201, 87, 0.3);
}

.header-icon {
  font-size: 2rem;
  animation: float 3s ease-in-out infinite;
}

@keyframes float {
  0%,
  100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}

.add-title {
  font-size: 1.75rem;
  margin-bottom: 0.5rem;
  color: #386641;
  font-weight: 700;
  letter-spacing: -0.02em;
}

.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 1.25rem;
}

.form-group label {
  font-size: 0.85em;
  font-weight: 600;
  color: rgba(56, 102, 65, 0.7);
  margin-bottom: 0.5rem;
  letter-spacing: 0.05em;
  text-transform: uppercase;
}

.input-box {
  padding: 0.875rem 1.125rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 0.75rem;
  color: #386641;
  font-size: 1em;
  font-weight: 500;
  background: rgba(255, 255, 255, 0.4);
  transition: all 0.2s ease-in-out;
  outline: none;
  box-sizing: border-box;
}

.input-box:focus {
  border-color: rgba(167, 201, 87, 0.6);
  box-shadow: 0 0 0 3px rgba(167, 201, 87, 0.1);
  background: rgba(255, 255, 255, 0.6);
}

.input-box:hover {
  border-color: rgba(56, 102, 65, 0.2);
}

/* Placeholder styling */
.input-box::placeholder {
  color: rgba(56, 102, 65, 0.4);
  font-weight: 400;
}

/* Select specific styling */
select.input-box {
  cursor: pointer;
  appearance: none;
  background-repeat: no-repeat;
  background-position: right 0.875rem center;
  padding-right: 2.5rem;
  font-weight: 500;
}

/* Option styling */
select.input-box option {
  padding: 0.75rem 1rem;
  background-color: #1a1a2e;
  color: #386641;
  font-size: 1em;
  font-weight: 500;
  line-height: 1.6;
  cursor: pointer;
}

select.input-box option:hover {
  background-color: rgba(167, 201, 87, 0.1);
  color: #386641;
}

select.input-box option:checked {
  background-color: rgba(167, 201, 87, 0.2);
  color: #a7c957;
  font-weight: 600;
}

select.input-box option:disabled {
  color: rgba(56, 102, 65, 0.3);
  cursor: not-allowed;
}

/* Button styling */
button[type="submit"] {
  margin-top: 0.75rem;
  padding: 1rem 1.5rem;
  background: #f2e8cf 100%;
  color: #386641;
  border: none;
  border-radius: 0.75rem;
  font-size: 1.05em;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(167, 201, 87, 0.3),
    0 0 20px rgba(167, 201, 87, 0.1);
  width: 100%;
  letter-spacing: 0.02em;
  text-transform: uppercase;
}

button[type="submit"]:hover {
  box-shadow: 0 6px 20px rgba(167, 201, 87, 0.4),
    0 0 30px rgba(167, 201, 87, 0.2);
  transform: translateY(-2px);
}

button[type="submit"]:active {
  transform: translateY(0);
  box-shadow: 0 4px 15px rgba(167, 201, 87, 0.3),
    0 0 20px rgba(167, 201, 87, 0.1);
}
</style>
