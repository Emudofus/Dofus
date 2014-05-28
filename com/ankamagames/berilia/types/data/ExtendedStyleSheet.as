package com.ankamagames.berilia.types.data
{
   import flash.text.StyleSheet;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.berilia.types.event.CssEvent;
   import flashx.textLayout.formats.TextLayoutFormat;
   import com.ankamagames.jerakine.managers.FontManager;
   import flash.text.AntiAliasType;
   import flash.text.engine.RenderingMode;
   import flash.text.engine.FontLookup;
   import flash.text.engine.CFFHinting;
   
   public class ExtendedStyleSheet extends StyleSheet
   {
      
      public function ExtendedStyleSheet(url:String) {
         this._inherit = new Array();
         this._inherited = 0;
         this._url = url;
         super();
      }
      
      protected static const _log:Logger;
      
      private static const CSS_INHERITANCE_KEYWORD:String = "extends";
      
      private static const CSS_FILES_KEYWORD:String = "files";
      
      private var _inherit:Array;
      
      private var _inherited:uint;
      
      private var _url:String;
      
      public function get inherit() : Array {
         return this._inherit;
      }
      
      public function get ready() : Boolean {
         return this._inherited == this._inherit.length;
      }
      
      public function get url() : String {
         return this._url;
      }
      
      override public function parseCSS(content:String) : void {
         var inheritance:Object = null;
         var regFile:RegExp = null;
         var match:Array = null;
         var file:String = null;
         var i:uint = 0;
         super.parseCSS(content);
         var find:int = styleNames.indexOf(CSS_INHERITANCE_KEYWORD);
         if(find != -1)
         {
            inheritance = getStyle(styleNames[find]);
            if(inheritance[CSS_FILES_KEYWORD])
            {
               regFile = new RegExp("url\\(\'?([^\']*)\'\\)?","g");
               match = String(inheritance[CSS_FILES_KEYWORD]).match(regFile);
               i = 0;
               while(i < match.length)
               {
                  file = String(match[i]).replace(regFile,"$1");
                  if(-1 == this._inherit.indexOf(file))
                  {
                     file = LangManager.getInstance().replaceKey(file);
                     CssManager.getInstance().askCss(file,new Callback(this.makeMerge,file));
                     this._inherit.push(file);
                  }
                  i++;
               }
            }
            else
            {
               _log.warn("property \'" + CSS_FILES_KEYWORD + "\' wasn\'t found (flash css doesn\'t support space between property name and colon, propertyName:value)");
               dispatchEvent(new CssEvent(CssEvent.CSS_PARSED,false,false,this));
            }
         }
         else
         {
            dispatchEvent(new CssEvent(CssEvent.CSS_PARSED,false,false,this));
         }
      }
      
      public function merge(stylesheet:ExtendedStyleSheet, replace:Boolean = false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      override public function toString() : String {
         var localDef:Object = null;
         var property:String = null;
         var result:String = "";
         result = result + ("File " + this.url + " :\n");
         var i:uint = 0;
         while(i < styleNames.length)
         {
            localDef = getStyle(styleNames[i]);
            result = result + (" [" + styleNames[i] + "]\n");
            for(property in localDef)
            {
               result = result + ("  " + property + " : " + localDef[property] + "\n");
            }
            i++;
         }
         return result;
      }
      
      public function TLFTransform(formatObject:Object) : TextLayoutFormat {
         var cssFont:String = null;
         var format:TextLayoutFormat = new TextLayoutFormat();
         if(formatObject["fontFamily"])
         {
            cssFont = formatObject["fontFamily"];
            if(FontManager.getInstance().getFontClassRenderingMode(cssFont) == AntiAliasType.ADVANCED)
            {
               format.renderingMode = RenderingMode.CFF;
               format.fontLookup = FontLookup.EMBEDDED_CFF;
               format.cffHinting = CFFHinting.HORIZONTAL_STEM;
            }
            format.fontFamily = cssFont;
         }
         if(formatObject["color"])
         {
            format.color = formatObject["color"];
         }
         if(formatObject["fontSize"])
         {
            format.fontSize = formatObject["fontSize"];
         }
         if(formatObject["paddingLeft"])
         {
            format.paddingLeft = formatObject["paddingLeft"];
         }
         if(formatObject["paddingRight"])
         {
            format.paddingRight = formatObject["paddingRight"];
         }
         if(formatObject["paddingBottom"])
         {
            format.paddingBottom = formatObject["paddingBottom"];
         }
         if(formatObject["paddingTop"])
         {
            format.paddingTop = formatObject["paddingTop"];
         }
         if(formatObject["textIndent"])
         {
            format.textIndent = formatObject["textIndent"];
         }
         return format;
      }
      
      private function makeMerge(sUrl:String) : void {
         this.merge(CssManager.getInstance().getCss(sUrl));
         this._inherited++;
         if(this.ready)
         {
            dispatchEvent(new CssEvent(CssEvent.CSS_PARSED,false,false,this));
         }
      }
   }
}
