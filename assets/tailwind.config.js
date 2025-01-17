// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/slax_web.ex",
    "../lib/slax_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        brand: "#FD4F00",
      }
    },
    animation: {
      typewriter: "typewriter 3s steps(11) infinite forwards",
      fadeIn: "fadeIn 2s cubic-bezier(0.4, 0, 0.6, 1)",
      fadeOut: "fadeOut 2s cubic-bezier(0.4, 0, 0.6, 1)",
      popIn: "popIn 0.5s cubic-bezier(0.4, 0, 0.6, 1)"
    },
    keyframes: {
      typewriter: {
        "0%": { left: "0%" },
        "80%": { left: "100%" }, // Animate to 100% in 80% of the time
        "100%": { left: "100%" }, // Hold at 100% for the remaining 20%
      },
      fadeIn: {
        "0%": {
          opacity: 0
        },
        "50%": {
          opacity: 0.3
        },
        "100%": {
          opacity: 1
        }
      },
      fadeOut: {
        "0%": {
          opacity: 1
        },
        "50%": {
          opacity: 0.3
        },
        "100%": {
          opacity: 0
        }
      },
      popIn: {
        "0%": {
          transform: "scale(0.1)",
          opacity: 0,
        },
        "100%": {
          transform: "scale(1)",
          opacity: 1,
        },
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) }
        })
      })
      matchComponents({
        "hero": ({ name, fullPath }) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, { values })
    })
  ]
}
