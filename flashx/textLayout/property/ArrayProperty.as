package flashx.textLayout.property
{
   import flashx.textLayout.formats.FormatValue;
   import __AS3__.vec.Vector;


   public class ArrayProperty extends Property
   {
         

      public function ArrayProperty(nameValue:String, defaultValue:Array, inherited:Boolean, categories:Vector.<String>, mType:Class) {
         super(nameValue,defaultValue,inherited,categories);
         this._memberType=mType;
      }



      private var _memberType:Class;

      public function get memberType() : Class {
         return this._memberType;
      }

      protected function checkArrayTypes(val:Object) : Boolean {
         var obj:Object = null;
         if(val==null)
         {
            return true;
         }
         if(!(val is Array))
         {
            return false;
         }
         if(this._memberType==null)
         {
            return true;
         }
         for each (obj in val as Array)
         {
            if(!(obj is this._memberType))
            {
               return false;
            }
         }
         return true;
      }

      override public function get defaultValue() : * {
         return super.defaultValue==null?null:(super.defaultValue as Array).slice();
      }

      override public function setHelper(currVal:*, newVal:*) : * {
         if(newVal===null)
         {
            newVal=undefined;
         }
         if((newVal==undefined)||(newVal==FormatValue.INHERIT))
         {
            return newVal;
         }
         if(newVal is String)
         {
            newVal=this.valueFromString(String(newVal));
         }
         if(!this.checkArrayTypes(newVal))
         {
            Property.errorHandler(this,newVal);
            return currVal;
         }
         return (newVal as Array).slice();
      }

      override public function concatInheritOnlyHelper(currVal:*, concatVal:*) : * {
         return (inherited)&&(currVal===undefined)||(currVal==FormatValue.INHERIT)?concatVal is Array?(concatVal as Array).slice():concatVal:currVal;
      }

      override public function concatHelper(currVal:*, concatVal:*) : * {
         if(inherited)
         {
            return (currVal===undefined)||(currVal==FormatValue.INHERIT)?concatVal is Array?(concatVal as Array).slice():concatVal:currVal;
         }
         if(currVal===undefined)
         {
            return this.defaultValue;
         }
         return currVal==FormatValue.INHERIT?concatVal is Array?(concatVal as Array).slice():concatVal:currVal;
      }

      override public function equalHelper(v1:*, v2:*) : Boolean {
         var v1Array:Array = null;
         var v2Array:Array = null;
         var desc:Object = null;
         var i:* = 0;
         if(this._memberType!=null)
         {
            v1Array=v1 as Array;
            v2Array=v2 as Array;
            if((v1Array)&&(v2Array))
            {
               if(v1Array.length==v2Array.length)
               {
                  desc=this._memberType.description;
                  i=0;
                  while(i<v1Array.length)
                  {
                     if(!Property.equalAllHelper(desc,v1[i],v2[i]))
                     {
                        return false;
                     }
                     i++;
                  }
                  return true;
               }
            }
         }
         return v1==v2;
      }

      override public function toXMLString(val:Object) : String {
         var member:Object = null;
         var addComma:* = false;
         var prop:Property = null;
         if(val==FormatValue.INHERIT)
         {
            return String(val);
         }
         var desc:Object = this._memberType.description;
         var rslt:String = "";
         var addSemi:Boolean = false;
         for each (member in val)
         {
            if(addSemi)
            {
               rslt=rslt+"; ";
            }
            addComma=false;
            for each (prop in desc)
            {
               val=member[prop.name];
               if(val!=null)
               {
                  if(addComma)
                  {
                     rslt=rslt+", ";
                  }
                  rslt=rslt+(prop.name+":"+prop.toXMLString(val));
                  addComma=true;
               }
            }
            addSemi=true;
         }
         return rslt;
      }

      private function valueFromString(str:String) : * {
         var attrs:String = null;
         var obj:Object = null;
         var attrsOne:Array = null;
         var attr:String = null;
         var nameValArr:Array = null;
         var propName:String = null;
         var propVal:String = null;
         var prop:Property = null;
         if((str==null)||(str==""))
         {
            return null;
         }
         if(str==FormatValue.INHERIT)
         {
            return str;
         }
         var result:Array = new Array();
         var desc:Object = this._memberType.description;
         var attrsAll:Array = str.split("; ");
         for each (attrs in attrsAll)
         {
            obj=new this._memberType();
            attrsOne=attrs.split(", ");
            for each (attr in attrsOne)
            {
               nameValArr=attr.split(":");
               propName=nameValArr[0];
               propVal=nameValArr[1];
               for each (prop in desc)
               {
                  if(prop.name==propName)
                  {
                     obj[propName]=prop.setHelper(propVal,obj[propName]);
                     break;
                  }
               }
            }
            result.push(obj);
         }
         return result;
      }
   }

}