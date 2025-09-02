// resources/js/utils/index.ts

// valueUpdater est un petit utilitaire pour mettre à jour une ref
export function valueUpdater<T>(updaterOrValue: T | ((old: T) => T), ref: { value: T }) {
  if (typeof updaterOrValue === "function") {
    // @ts-ignore : updaterOrValue est une fonction
    ref.value = updaterOrValue(ref.value)
  } else {
    ref.value = updaterOrValue
  }
}
