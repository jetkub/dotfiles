#!/usr/bin/env -S uv run --script

# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "numpy",
#     "pillow",
# ]
# [tool.uv]
# exclude-newer = "2025-02-01T00:00:00Z"
# ///

import numpy as np
from PIL import Image


def hex_to_rgb(hex_color):
    """Convert hex color string to RGB tuple"""
    hex_color = hex_color.lstrip("#")
    return np.array([int(hex_color[i : i + 2], 16) for i in (0, 2, 4)])


def apply_palette(image_path, output_path, hex_colors, blend_factor=0.8):
    """
    Apply color palette while preserving image detail
    blend_factor: 0.0 = original image, 1.0 = full palette colors
    """
    # Convert hex colors to RGB numpy array
    palette = np.array([hex_to_rgb(color) for color in hex_colors])

    # Load image
    img = Image.open(image_path)
    img = img.convert("RGB")
    img_array = np.array(img)

    # Reshape image to 2D array of pixels
    pixels = img_array.reshape(-1, 3)

    # Calculate luminance of each pixel (grayscale intensity)
    luminance = np.dot(pixels, [0.2989, 0.5870, 0.1140])

    # Calculate luminance of palette colors
    palette_luminance = np.dot(palette, [0.2989, 0.5870, 0.1140])

    # Find closest palette color for each pixel considering both color and luminance
    # Weight luminance in the distance calculation
    distances = np.zeros((len(pixels), len(palette)))

    for i, palette_color in enumerate(palette):
        color_diff = pixels - palette_color
        color_distance = np.sqrt(np.sum(color_diff * color_diff, axis=1))
        lum_diff = np.abs(luminance - palette_luminance[i])
        # Combine color and luminance distances with weights
        distances[:, i] = color_distance + lum_diff * 0.5

    closest_palette_indices = np.argmin(distances, axis=1)
    palette_colors = palette[closest_palette_indices]

    # Blend between original and palette colors
    new_pixels = (pixels * (1 - blend_factor) + palette_colors * blend_factor).astype(
        np.uint8
    )

    # Reshape back to original image dimensions
    new_img_array = new_pixels.reshape(img_array.shape)

    # Convert to PIL Image and save
    new_img = Image.fromarray(new_img_array)
    with open(output_path, "wb") as f:
        new_img.save(f, format="PNG", optimize=True)


if __name__ == "__main__":
    import sys

    # fmt: off
    colors = [
        "#000000", "#0000df", "#101010", "#151515", "#1c1c1c",
        "#1f1f1f", "#2B5B77", "#2D7067", "#302028", "#333333",
        "#333d1f", "#384048", "#40000a", "#403c41", "#404040",
        "#437019", "#535d66", "#540063", "#556633", "#556779",
        "#561313", "#605958", "#606060", "#668799", "#700089",
        "#70b950", "#777777", "#799d6a", "#8197bf", "#87d7ff",
        "#888888", "#8fbfdc", "#902020", "#9098A0", "#99ad6a",
        "#a0a8b0", "#afd787", "#b0b8c0", "#b0d0f0", "#c6b6ee",
        "#c7c7c7", "#cc88a3", "#ccc5c4", "#d2ebbe", "#d7af87",
        "#d98870", "#dad085", "#dddddd", "#e6a75a", "#e8e8d3",
        "#f0f0f0", "#fad07a", "#ff0000", "#ffaf00", "#ffffff",
    ]
    # fmt: on

    if len(sys.argv) != 3:
        print("Usage: uv run --script palette_mapper.py [INPUT] [OUTPUT]")
        sys.exit(1)

    apply_palette(
        sys.argv[1],
        sys.argv[2],
        colors,
        blend_factor=0.5,  # lower == less blend, higher == more.
    )
