package mx.utils
{
   import mx.core.mx_internal;
   import flash.utils.getQualifiedClassName;
   import flash.display.DisplayObject;
   import mx.core.IRepeaterClient;

   use namespace mx_internal;

   public class NameUtil extends Object
   {
         

      public function NameUtil() {
         super();
      }

      mx_internal  static const VERSION:String = "4.6.0.23201";

      private static var counter:int = 0;

      public static function createUniqueName(object:Object) : String {
         if(!object)
         {
            return null;
         }
         var name:String = getQualifiedClassName(object);
         var index:int = name.indexOf("::");
         if(index!=-1)
         {
            name=name.substr(index+2);
         }
         var charCode:int = name.charCodeAt(name.length-1);
         if((charCode>=48)&&(charCode<=57))
         {
            name=name+"_";
         }
         return name+counter++;
      }

      public static function displayObjectToString(displayObject:DisplayObject) : String {
         var result:String = null;
         var o:DisplayObject = null;
         var s:String = null;
         var indices:Array = null;
         try
         {
            o=displayObject;
            while(o!=null)
            {
               if((o.parent)&&(o.stage)&&(o.parent==o.stage))
               {
               }
               else
               {
                  s=("id" in o)&&(o["id"])?o["id"]:o.name;
                  if(o is IRepeaterClient)
                  {
                     indices=IRepeaterClient(o).instanceIndices;
                     if(indices)
                     {
                        s=s+("["+indices.join("][")+"]");
                     }
                  }
                  result=result==null?s:s+"."+result;
                  o=o.parent;
                  continue;
               }
            }
         }
         catch(e:SecurityError)
         {
         }
         return result;
      }

      public static function getUnqualifiedClassName(object:Object) : String {
         var name:String = null;
         if(object is String)
         {
            name=object as String;
         }
         else
         {
            name=getQualifiedClassName(object);
         }
         var index:int = name.indexOf("::");
         if(index!=-1)
         {
            name=name.substr(index+2);
         }
         return name;
      }


   }

}