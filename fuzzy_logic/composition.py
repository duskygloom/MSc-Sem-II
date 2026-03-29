import matplotlib.pyplot as plt
import numpy as np


def max_dot(r: np.ndarray, s: np.ndarray) -> np.ndarray:
    if r.ndim != 2 or s.ndim != 2:
        raise ValueError("r and s should be matrices")
    if r.shape[1] != s.shape[0]:
        raise ValueError("incompatible size of matrix r and s")
    c = np.zeros((r.shape[0], s.shape[1]), dtype=float)
    for i in range(r.shape[0]):
        for j in range(s.shape[1]):
            max_value = 0.0
            for k in range(r.shape[1]):
                value = r[i, k] * s[k, j]
                if value > max_value:
                    max_value = value
            c[i, j] = np.round(max_value, 2)
    return c


def max_min(r: np.ndarray, s: np.ndarray) -> np.ndarray:
    if r.ndim != 2 or s.ndim != 2:
        raise ValueError("r and s should be matrices")
    if r.shape[1] != s.shape[0]:
        raise ValueError("incompatible size of matrix r and s")
    c = np.zeros((r.shape[0], s.shape[1]), dtype=float)
    for i in range(r.shape[0]):
        for j in range(s.shape[1]):
            max_value = 0.0
            for k in range(r.shape[1]):
                value = min(r[i, k], s[k, j])
                if value > max_value:
                    max_value = value
            c[i, j] = np.round(max_value, 2)
    return c


np.random.seed(1)
x = np.array([np.round(np.random.rand(), 2) for _ in range(4)], dtype=float).reshape(
    (2, 2)
)
y = np.array([np.round(np.random.rand(), 2) for _ in range(4)], dtype=float).reshape(
    (2, 2)
)

# x = np.array([[0.7, 0.5], [0.8, 0.4]])
# y = np.array([[0.9, 0.6, 0.2], [0.1, 0.7, 0.5]])

x = np.array([[0.6, 0.6], [0.6, 0.8], [0.1, 0.4]])
y = np.array([[0.8, 0.2], [0.4, 0.7]])

def plot_composition():
    figure, axes = plt.subplots(1, 3)
    x = np.arange(0, 1, 0.05)
    for i in x:
        for j in x:
            min_value = min(i, j)
            axes[0].scatter(
                i,
                j,
                c=f"#000000{int(min_value * 255):02X}",
            )
            dot_value = i * j
            axes[1].scatter(
                i,
                j,
                c=f"#000000{int(dot_value * 255):02X}",
            )
            axes[2].scatter(
                i,
                j,
                c=f"#000000{int((1 - abs(dot_value - min_value)) * 255):02X}",
            )
    figure.show()


print("Relation R:")
print(x)
print()

print("Relation S:")
print(y)
print()

print("Composition R.S (max-dot):")
print(max_dot(x, y))
print()

print("Composition R.S (max-min):")
print(max_min(x, y))
print()
