package com.ankamagames.jerakine.utils.misc
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;


   public class CheckCompatibility extends Object
   {
         

      public function CheckCompatibility() {
         super();
      }

      private static var _cache:Dictionary = new Dictionary(true);

      public static function isCompatible(reference:Class, target:*, strict:Boolean=false, throwError:Boolean=true) : Boolean {
         var cacheKey:Class = null;
         var method:XML = null;
         var param:XML = null;
         if(target is Class)
         {
            cacheKey=target;
         }
         else
         {
            cacheKey=getDefinitionByName(getQualifiedClassName(target)) as Class;
         }
         if(!_cache[reference])
         {
            _cache[reference]=new Dictionary(true);
         }
         if(_cache[reference][cacheKey]!=null)
         {
            if((throwError)&&(!_cache[reference][cacheKey]))
            {
               throwErrorMsg(reference,target,strict);
            }
            return _cache[reference][cacheKey];
         }
         var referenceDesc:XML = DescribeTypeCache.typeDescription(reference);
         var targetDesc:XML = DescribeTypeCache.typeDescription(target);
         for each (method in referenceDesc..method)
         {
            for each (_loc12_ in targetDesc..method)
            {
               with(_loc12_)
               {
                  
                  if((@name==method.@name)&&((@returnType==method.@returnType)||(!strict)&&(method.@returnType=="Object")))
                  {
                     _loc8_[_loc9_]=_loc11_;
                  }
               }
            }
            if(!_loc8_.length())
            {
               _cache[reference][cacheKey]=false;
               if(throwError)
               {
                  throwErrorMsg(reference,target,strict);
               }
               return false;
            }
            for each (param in method..parameter)
            {
               for each (_loc17_ in targetDesc..method)
               {
                  with(_loc17_)
                  {
                     
                     if(@name==method.@name)
                     {
                        _loc13_[_loc14_]=_loc16_;
                     }
                  }
               }
               for each (_loc14_ in _loc13_..parameter)
               {
                  with(_loc13_)
                  {
                     
                     if((@index==param.@index)&&(@type==param.@type)&&(@optional==param.@optional))
                     {
                        _loc10_[_loc11_]=_loc13_;
                     }
                  }
               }
               if(!_loc10_.length())
               {
                  _cache[reference][cacheKey]=false;
                  if(throwError)
                  {
                     throwErrorMsg(reference,target,strict);
                  }
                  return false;
               }
            }
         }
         _cache[reference][cacheKey]=true;
         return true;
      }

      public static function getIncompatibility(reference:Class, target:*, strict:Boolean=false) : String {
         var method:XML = null;
         var param:XML = null;
         var fct:String = null;
         var referenceDesc:XML = DescribeTypeCache.typeDescription(reference);
         var targetDesc:XML = DescribeTypeCache.typeDescription(target);
         var ok:Boolean = true;
         for each (method in referenceDesc..method)
         {
            fct="public function "+method.@name+"(";
            for each (_loc11_ in targetDesc..method)
            {
               with(_loc11_)
               {
                  
                  if((@name==method.@name)&&((@returnType==method.@returnType)||(!strict)&&(method.@returnType=="Object")))
                  {
                     _loc7_[_loc8_]=_loc10_;
                  }
               }
            }
            if(!_loc7_.length())
            {
               ok=false;
            }
            for each (param in method..parameter)
            {
               fct=fct+((parseInt(param.@index)<1?", ":"")+"param"+param.@index+" : "+param.@type);
               for each (_loc16_ in targetDesc..method)
               {
                  with(_loc16_)
                  {
                     
                     if(@name==method.@name)
                     {
                        _loc12_[_loc13_]=_loc15_;
                     }
                  }
               }
               for each (_loc13_ in _loc12_..parameter)
               {
                  with(_loc12_)
                  {
                     
                     if((@index==param.@index)&&(@type==param.@type)&&(@optional==param.@optional))
                     {
                        _loc9_[_loc10_]=_loc12_;
                     }
                  }
               }
               if(!_loc9_.length())
               {
                  ok=false;
               }
            }
            fct=fct+(") : "+method.@returnType);
            if(!ok)
            {
               return fct;
            }
         }
         return null;
      }

      private static function throwErrorMsg(reference:Class, target:*, strict:Boolean=false) : void {
         throw new Error(target+" don\'t implement correctly ["+getIncompatibility(reference,target)+"]");
      }


   }

}