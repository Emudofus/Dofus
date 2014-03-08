package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.RGB;
   import com.somerandomdude.colortoolkit.spaces.IColorSpace;
   import com.somerandomdude.colortoolkit.Color;
   
   public dynamic class ColorList extends Array
   {
      
      public function ColorList(param1:int=0) {
         super(param1);
      }
      
      public function empty() : void {
         while(length)
         {
            this.splice(0,length);
         }
      }
      
      public function toRGB() : ColorList {
         var _loc1_:ColorList = new ColorList();
         var _loc2_:RGB = new RGB();
         var _loc3_:* = 0;
         while(_loc3_ < this.length)
         {
            _loc2_.color = this[_loc3_] is IColorSpace?this[_loc3_].color:this[_loc3_];
            _loc1_.push(_loc2_.toRGB());
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function toHSB() : ColorList {
         var _loc1_:ColorList = new ColorList();
         var _loc2_:RGB = new RGB();
         var _loc3_:* = 0;
         while(_loc3_ < this.length)
         {
            _loc2_.color = this[_loc3_] is IColorSpace?this[_loc3_].color:this[_loc3_];
            _loc1_.push(_loc2_.toHSB());
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function toCMYK() : ColorList {
         var _loc1_:ColorList = new ColorList();
         var _loc2_:RGB = new RGB();
         var _loc3_:* = 0;
         while(_loc3_ < this.length)
         {
            _loc2_.color = this[_loc3_] is IColorSpace?this[_loc3_].color:this[_loc3_];
            _loc1_.push(_loc2_.toCMYK());
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function toColor() : ColorList {
         var _loc1_:ColorList = new ColorList();
         var _loc2_:RGB = new RGB();
         var _loc3_:* = 0;
         while(_loc3_ < this.length)
         {
            _loc1_.push(new Color(this[_loc3_] is IColorSpace?this[_loc3_].color:this[_loc3_]));
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function toHex() : ColorList {
         var _loc1_:ColorList = new ColorList();
         var _loc2_:RGB = new RGB();
         var _loc3_:* = 0;
         while(_loc3_ < this.length)
         {
            _loc2_.color = this[_loc3_] is IColorSpace?this[_loc3_].color:this[_loc3_];
            _loc1_.push(_loc2_.color);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function toLab() : ColorList {
         var _loc1_:ColorList = new ColorList();
         var _loc2_:RGB = new RGB();
         var _loc3_:* = 0;
         while(_loc3_ < this.length)
         {
            _loc2_.color = this[_loc3_] is IColorSpace?this[_loc3_].color:this[_loc3_];
            _loc1_.push(_loc2_.toLab());
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function toXYZ() : ColorList {
         var _loc1_:ColorList = new ColorList();
         var _loc2_:RGB = new RGB();
         var _loc3_:* = 0;
         while(_loc3_ < this.length)
         {
            _loc2_.color = this[_loc3_] is IColorSpace?this[_loc3_].color:this[_loc3_];
            _loc1_.push(_loc2_.toXYZ());
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function toHSL() : ColorList {
         var _loc1_:ColorList = new ColorList();
         var _loc2_:RGB = new RGB();
         var _loc3_:* = 0;
         while(_loc3_ < this.length)
         {
            _loc2_.color = this[_loc3_] is IColorSpace?this[_loc3_].color:this[_loc3_];
            _loc1_.push(_loc2_.toHSL()());
            _loc3_++;
         }
         return _loc1_;
      }
   }
}
