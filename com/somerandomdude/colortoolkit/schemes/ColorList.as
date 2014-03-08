package com.somerandomdude.colortoolkit.schemes
{
   import com.somerandomdude.colortoolkit.spaces.RGB;
   import com.somerandomdude.colortoolkit.spaces.IColorSpace;
   import com.somerandomdude.colortoolkit.Color;
   
   public dynamic class ColorList extends Array
   {
      
      public function ColorList(numElements:int=0) {
         super(numElements);
      }
      
      public function empty() : void {
         while(length)
         {
            this.splice(0,length);
         }
      }
      
      public function toRGB() : ColorList {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         var i:int = 0;
         while(i < this.length)
         {
            rgb.color = this[i] is IColorSpace?this[i].color:this[i];
            list.push(rgb.toRGB());
            i++;
         }
         return list;
      }
      
      public function toHSB() : ColorList {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         var i:int = 0;
         while(i < this.length)
         {
            rgb.color = this[i] is IColorSpace?this[i].color:this[i];
            list.push(rgb.toHSB());
            i++;
         }
         return list;
      }
      
      public function toCMYK() : ColorList {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         var i:int = 0;
         while(i < this.length)
         {
            rgb.color = this[i] is IColorSpace?this[i].color:this[i];
            list.push(rgb.toCMYK());
            i++;
         }
         return list;
      }
      
      public function toColor() : ColorList {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         var i:int = 0;
         while(i < this.length)
         {
            list.push(new Color(this[i] is IColorSpace?this[i].color:this[i]));
            i++;
         }
         return list;
      }
      
      public function toHex() : ColorList {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         var i:int = 0;
         while(i < this.length)
         {
            rgb.color = this[i] is IColorSpace?this[i].color:this[i];
            list.push(rgb.color);
            i++;
         }
         return list;
      }
      
      public function toLab() : ColorList {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         var i:int = 0;
         while(i < this.length)
         {
            rgb.color = this[i] is IColorSpace?this[i].color:this[i];
            list.push(rgb.toLab());
            i++;
         }
         return list;
      }
      
      public function toXYZ() : ColorList {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         var i:int = 0;
         while(i < this.length)
         {
            rgb.color = this[i] is IColorSpace?this[i].color:this[i];
            list.push(rgb.toXYZ());
            i++;
         }
         return list;
      }
      
      public function toHSL() : ColorList {
         var list:ColorList = new ColorList();
         var rgb:RGB = new RGB();
         var i:int = 0;
         while(i < this.length)
         {
            rgb.color = this[i] is IColorSpace?this[i].color:this[i];
            list.push(rgb.toHSL()());
            i++;
         }
         return list;
      }
   }
}
