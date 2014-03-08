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
      
      public function ExtendedStyleSheet(param1:String) {
         this._inherit = new Array();
         this._inherited = 0;
         this._url = param1;
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExtendedStyleSheet));
      
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
      
      override public function parseCSS(param1:String) : void {
         var _loc3_:Object = null;
         var _loc4_:RegExp = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         super.parseCSS(param1);
         var _loc2_:int = styleNames.indexOf(CSS_INHERITANCE_KEYWORD);
         if(_loc2_ != -1)
         {
            _loc3_ = getStyle(styleNames[_loc2_]);
            if(_loc3_[CSS_FILES_KEYWORD])
            {
               _loc4_ = new RegExp("url\\(\'?([^\']*)\'\\)?","g");
               _loc5_ = String(_loc3_[CSS_FILES_KEYWORD]).match(_loc4_);
               _loc7_ = 0;
               while(_loc7_ < _loc5_.length)
               {
                  _loc6_ = String(_loc5_[_loc7_]).replace(_loc4_,"$1");
                  if(-1 == this._inherit.indexOf(_loc6_))
                  {
                     _loc6_ = LangManager.getInstance().replaceKey(_loc6_);
                     CssManager.getInstance().askCss(_loc6_,new Callback(this.makeMerge,_loc6_));
                     this._inherit.push(_loc6_);
                  }
                  _loc7_++;
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
      
      public function merge(param1:ExtendedStyleSheet, param2:Boolean=false) : void {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc6_:String = null;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.styleNames.length)
         {
            if(param1.styleNames[_loc5_] != CSS_INHERITANCE_KEYWORD)
            {
               _loc3_ = getStyle(param1.styleNames[_loc5_]);
               _loc4_ = param1.getStyle(param1.styleNames[_loc5_]);
               if(_loc3_)
               {
                  for (_loc6_ in _loc4_)
                  {
                     if(_loc3_[_loc6_] == null || (param2))
                     {
                        _loc3_[_loc6_] = _loc4_[_loc6_];
                     }
                  }
                  _loc4_ = _loc3_;
               }
               setStyle(param1.styleNames[_loc5_],_loc4_);
            }
            _loc5_++;
         }
      }
      
      override public function toString() : String {
         var _loc2_:Object = null;
         var _loc4_:String = null;
         var _loc1_:* = "";
         _loc1_ = _loc1_ + ("File " + this.url + " :\n");
         var _loc3_:uint = 0;
         while(_loc3_ < styleNames.length)
         {
            _loc2_ = getStyle(styleNames[_loc3_]);
            _loc1_ = _loc1_ + (" [" + styleNames[_loc3_] + "]\n");
            for (_loc4_ in _loc2_)
            {
               _loc1_ = _loc1_ + ("  " + _loc4_ + " : " + _loc2_[_loc4_] + "\n");
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function TLFTransform(param1:Object) : TextLayoutFormat {
         var _loc3_:String = null;
         var _loc2_:TextLayoutFormat = new TextLayoutFormat();
         if(param1["fontFamily"])
         {
            _loc3_ = param1["fontFamily"];
            if(FontManager.getInstance().getFontClassRenderingMode(_loc3_) == AntiAliasType.ADVANCED)
            {
               _loc2_.renderingMode = RenderingMode.CFF;
               _loc2_.fontLookup = FontLookup.EMBEDDED_CFF;
               _loc2_.cffHinting = CFFHinting.HORIZONTAL_STEM;
            }
            _loc2_.fontFamily = _loc3_;
         }
         if(param1["color"])
         {
            _loc2_.color = param1["color"];
         }
         if(param1["fontSize"])
         {
            _loc2_.fontSize = param1["fontSize"];
         }
         if(param1["paddingLeft"])
         {
            _loc2_.paddingLeft = param1["paddingLeft"];
         }
         if(param1["paddingRight"])
         {
            _loc2_.paddingRight = param1["paddingRight"];
         }
         if(param1["paddingBottom"])
         {
            _loc2_.paddingBottom = param1["paddingBottom"];
         }
         if(param1["paddingTop"])
         {
            _loc2_.paddingTop = param1["paddingTop"];
         }
         if(param1["textIndent"])
         {
            _loc2_.textIndent = param1["textIndent"];
         }
         return _loc2_;
      }
      
      private function makeMerge(param1:String) : void {
         this.merge(CssManager.getInstance().getCss(param1));
         this._inherited++;
         if(this.ready)
         {
            dispatchEvent(new CssEvent(CssEvent.CSS_PARSED,false,false,this));
         }
      }
   }
}
