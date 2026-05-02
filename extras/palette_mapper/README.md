# Image Palette Mapper

A simple Python script that remaps image colors to a predefined color palette while preserving image detail. Built using uv for dependency management.

## Requirements

- Python 3.12+
- uv

## Installation

1. Install uv if you haven't already:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

2. The script includes its own dependencies in the header, so no additional installation is needed.

## Usage

```bash
./palette_mapper.py input.png output.png
```

The script will process your input image and create a new version using the predefined color palette.

## How It Works

- Uses a blend factor of 0.5 by default (can be modified in the script)
  - Lower values stay closer to the original image
  - Higher values use more of the palette colors
- Preserves image detail while applying the palette colors
- Considers both color similarity and luminance when matching colors
- Optimizes the output PNG file

## Color Palette

The script includes a predefined palette of 55 colors commonly used in the jellybeans theme. The colors range from dark to light and include various hues suitable for theme-based image manipulation.

## Modifying

If you want to use different colors, modify the `colors` list in the script. Colors should be in hex format (e.g., "#ffffff").

To adjust the color blending strength, modify the `blend_factor` parameter in the `apply_palette` call at the bottom of the script:
```python
    apply_palette(
        sys.argv[1],
        sys.argv[2],
        colors,
        blend_factor=0.5,  # lower == less blend, higher == more.
    )
```

## Notes

- Works with PNG and JPG images
- Uses NumPy for efficient image processing
- Outputs optimized PNG files
- Processing time depends on image size
