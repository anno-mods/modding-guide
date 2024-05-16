# Codesnippets (xml)

(see here for lua: [codesnippets](../Scripting/CodeSnippets.md))


- [ModOp examples](https://github.com/jakobharder/anno1800-mod-loader/blob/main/doc/modop-examples.md)
- [Serps codesnippets](https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/blob/main/CodeSnippets.md)
- [Standalone Color picker (converter) for Anno colour format](https://discord.com/channels/578443209940926465/581158181078695948/833369411830284318), written by Anno Discord User "Fam".
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```html
  <html>
    <head>
      <title>🎨 Color Picker</title>

      <style>
        html {
          font-family: sans-serif;
          font-size: 12px;
        }
        h3 {
          opacity: 0.4;
          margin-bottom: 0.25em;
          margin-top: 2em;
          padding-left: 6.1em;
        }
        label {
          display: inline-block;
          text-align: right;
          margin-right: 1em;
          width: 6em;
        }
        input[type=range] {
          width: 255px;
          margin-left: -2px;
        }
        #section-rgba button {
          margin-left: 6.5em;
          margin-top: 0.25em;
        }
        #section-rgba samp {
          display: block;
          padding-left: 7.2em;
          padding-top: 1em;
          opacity: 0.6;
        }
        #preview {
          background-image: linear-gradient(135deg, #e6e6e6 25%, #ffffff 25%, #ffffff 50%, #e6e6e6 50%, #e6e6e6 75%, #ffffff 75%, #ffffff 100%);
          background-size: 45.25px 45.25px;
          position: absolute;
          top: 0;
          left: 30em;
          bottom: 0;
          right: 0;
          height: auto;
          width: auto;
        }
        #preview p {
          margin: 2em;
          height: 4em;
        }
      </style>
    </head>
    <body>
      <section id="section-picker">
        <h3>Color Picker</h3>
        <div class="field">
          <label for="pickercolor">Color</label>
          <input id="pickercolor" type="color" value="#6ef567">
        </div>
        <div class="field">
          <div class="field">
            <label for="pickeralpha">Alpha</label>
            <input id="pickeralpha" value="64.71" type="number" min="0" max="100">%
          </div>
          <div class="field">
            <label></label>
            <input id="pickeralpharange" type="range" min="1" max="100" value="64.71">
          </div>
        </div>
      </section>

      <section id="section-hex">
        <h3>Hex</h3>
        <div class="field">
          <label for="hexcolor">Hex</label>
          <input id="hexcolor"><button class="copy">Copy</button>
        </div>
      </section>

      <section id="section-int">
        <h3>Integer Color <em>(used by game)</em></h3>
        <div class="field">
          <label for="intcolor">Int Color</label>
          <input id="intcolor"><button class="copy">Copy</button>
        </div>
      </section>

      <section id="section-rgba">
        <h3>RGBA</h3>
        <div class="field">
          <label for="rgbar">R</label>
          <input id="rgbar" type="number" min="0" max="255">
        </div>
        <div class="field">
          <label for="rgbag">G</label>
          <input id="rgbag" type="number" min="0" max="255">
        </div>
        <div class="field">
          <label for="rgbab">B</label>
          <input id="rgbab" type="number" min="0" max="255">
        </div>
        <div class="field">
          <label for="rgbaa">A</label>
          <input id="rgbaa" type="number" min="0" max="255">
        </div>
        <samp id="rgbacode"></samp>
      </section>

      <div id="preview">
        <p></p>
      </div>

      <script type="text/javascript">

        const el = document.getElementById.bind(document);

        // When a section is updated
        function update( changedSection, valueOverride ) {

          // Calculate the new value depending on which section changed
          let newColorRgba = {r:0,g:0,b:0,a:0};

          switch(changedSection) {
            case 'section-hex':
              newColorRgba = hex2rgba(el('hexcolor').value);
              break;
            case 'section-rgba':
              newColorRgba = {
                r: el('rgbar').value*1,
                g: el('rgbag').value*1,
                b: el('rgbab').value*1,
                a: el('rgbaa').value*1
              }
              break;
            case 'section-int':
              newColorRgba = int2rgba(el('intcolor').value);
              break;
            case 'section-picker':
              newColorRgba = hex2rgba(el('pickercolor').value);
              newColorRgba.a = Math.round(el('pickeralpha').value * 2.55);
              break;
          }

          if( changedSection != 'section-hex' ) {
            el('hexcolor').value = rgba2hex(newColorRgba);
          }
          if( changedSection != 'section-rgba' ) {
            el('rgbar').value = newColorRgba.r;
            el('rgbag').value = newColorRgba.g;
            el('rgbab').value = newColorRgba.b;
            el('rgbaa').value = newColorRgba.a;
          }
          if( changedSection != 'section-int' ) {
            el('intcolor').value = rgba2int(newColorRgba);
          }
          if( changedSection != 'section-picker' ) {
            el('pickercolor').value = rgba2hex(newColorRgba).substring(0,7);
            el('pickeralpha').value = Math.round( (newColorRgba.a/2.55) * 100000) / 100000;
            el('pickeralpharange').value = el('pickeralpha').value;
          }

          let alphaPct = Math.round((newColorRgba.a / 255)*10000)/10000;
          let cssColor = `rgba(${newColorRgba.r},${newColorRgba.g},${newColorRgba.b},${alphaPct})`
          el('rgbacode').innerText = cssColor;

          document.querySelectorAll('#preview p')[0].style.backgroundColor = cssColor;
          
        }

        document.addEventListener("DOMContentLoaded",()=>{
          update('section-picker');
        });

        // When color picker is updated
        el('pickercolor').addEventListener("change", () => {
          update('section-picker');
        }, false);
        el('pickeralpha').addEventListener("change", () => {
          el('pickeralpharange').value = el('pickeralpha').value;
          update('section-picker');
        }, false);
        el('pickeralpharange').addEventListener("input", () => {
          el('pickeralpha').value = el('pickeralpharange').value;
          update('section-picker');
        }, false);

        // When hex is updated
        Array.from(document.querySelectorAll('#section-hex input')).forEach( e => {e.addEventListener("change", () => {
          update('section-hex');
        }, false)});
        Array.from(document.querySelectorAll('#section-hex input')).forEach( e => {e.addEventListener("input", () => {
          update('section-hex');
        }, false)});

        // When int is updated
        Array.from(document.querySelectorAll('#section-int input')).forEach( e => {e.addEventListener("change", () => {
          update('section-int');
        }, false)});

        // When rgba is updated
        Array.from(document.querySelectorAll('#section-rgba input')).forEach( e => {e.addEventListener("change", () => {
          update('section-rgba');
        }, false)});

        Array.from(document.querySelectorAll('button.copy')).forEach( e => {e.addEventListener("click", (e) => {
          console.log(e.target.previousSibling);
          let val;
          if( e.target.previousSibling.value ) {
            val = e.target.previousSibling.value;
            e.target.previousSibling.select();
            document.execCommand("copy");
          }
        }, false)});

        function rgba2hex( rgba ){
          return '#' + [rgba.r,rgba.g,rgba.b,rgba.a].map(x => {
            const hex = x.toString(16)
            return hex.length === 1 ? '0' + hex : hex
          }).join('');
        }
        function hex2rgba(hex) {
          let parts = hex.toUpperCase().match(/[#]?([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})?/);
          let r = parseInt(parts[1],16);
          let g = parseInt(parts[2],16);
          let b = parseInt(parts[3],16);
          let a = parts[4] ? parseInt(parts[4],16) : 255;
          return {r:r,g:g,b:b,a:a};
        }
        function int2rgba(num) {
          num >>>= 0;
          var b = num & 0xFF,
            g = (num & 0xFF00) >>> 8,
            r = (num & 0xFF0000) >>> 16,
            a = Math.round(10000*(( (num & 0xFF000000) >>> 24 )))/10000;
          return {r:r,g:g,b:b,a:a};
        }
        function rgba2int(rgba) {
          let {r,g,b,a} = rgba;
          return ((b>>>0)+(g<<8>>>0)+(r<<16>>>0)+(a<<24>>>0))>>0;
        }
        function hex2int(hex) {
          let parts = hex.toUpperCase().match(/[#]?([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})?/);
          let r = parseInt(parts[1],16);
          let g = parseInt(parts[2],16);
          let b = parseInt(parts[3],16);
          let a = parts[4] ? parseInt(parts[4],16) : 255;
          return ((b>>>0)+(g<<8>>>0)+(r<<16>>>0)+(a<<24>>>0))>>0;
        }
      </script>
    </body>
  </html>
  ```
  </details>
