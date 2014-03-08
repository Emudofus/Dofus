package com.ankamagames.dofus.console.moduleLogger
{
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import flash.utils.describeType;
   
   public final class TypeMessage extends Object
   {
      
      public function TypeMessage(... rest) {
         var object:Object = null;
         var args:Array = rest;
         this.search1 = new RegExp("<","g");
         this.search2 = new RegExp(">","g");
         this.vectorExp = new RegExp("Vector.<(.*)::(.*)>","g");
         super();
         try
         {
            object = args[0];
            if(object is String && args.length == 2)
            {
               this.displayLog(object as String,args[1]);
            }
            else
            {
               if(object is Hook)
               {
                  this.displayHookInformations(object as Hook,args[1]);
               }
               else
               {
                  if(object is Action)
                  {
                     this.displayActionInformations(object as Action);
                  }
                  else
                  {
                     if(object is Message)
                     {
                        this.displayInteractionMessage(object as Message,args[1]);
                     }
                     else
                     {
                        if(object is Bind)
                        {
                           this.displayBind(object as Bind,args[1]);
                        }
                        else
                        {
                           this.name = "trace";
                           this.textInfo = object as String;
                           this.type = LOG;
                        }
                     }
                  }
               }
            }
         }
         catch(e:Error)
         {
            if(!(object is String))
            {
               name = "trace";
               textInfo = "<span class=\'red\'>" + e.getStackTrace() + "</span>";
            }
         }
         return;
         if(object is String && args.length == 2)
         {
            this.displayLog(object as String,args[1]);
         }
         else
         {
            if(object is Hook)
            {
               this.displayHookInformations(object as Hook,args[1]);
            }
            else
            {
               if(object is Action)
               {
                  this.displayActionInformations(object as Action);
               }
               else
               {
                  if(object is Message)
                  {
                     this.displayInteractionMessage(object as Message,args[1]);
                  }
                  else
                  {
                     if(object is Bind)
                     {
                        this.displayBind(object as Bind,args[1]);
                     }
                     else
                     {
                        this.name = "trace";
                        this.textInfo = object as String;
                        this.type = LOG;
                     }
                  }
               }
            }
         }
      }
      
      public static const TYPE_HOOK:int = 0;
      
      public static const TYPE_UI:int = 1;
      
      public static const TYPE_ACTION:int = 2;
      
      public static const TYPE_SHORTCUT:int = 3;
      
      public static const TYPE_MODULE_LOG:int = 4;
      
      public static const LOG:int = 5;
      
      public static const LOG_CHAT:int = 17;
      
      public static const TAB:String = "                  • ";
      
      public var name:String = "";
      
      public var textInfo:String;
      
      public var type:int = -1;
      
      public var logType:int = -1;
      
      private var search1:RegExp;
      
      private var search2:RegExp;
      
      private function displayBind(param1:Bind, param2:Object) : void {
         this.type = TYPE_SHORTCUT;
         var _loc3_:String = "Shortcut : " + param1.key.toUpperCase() + " --&gt; \"" + param1.targetedShortcut + "\" " + (param1.alt?"Alt+":"") + (param1.ctrl?"Ctrl+":"") + (param1.shift?"Shift+":"");
         this.name = "Shortcut";
         this.textInfo = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'yellow\'> BIND   : <a href=\'event:@shortcut\'>" + _loc3_ + "</a></span>" + "\n<span class=\'gray+\'>" + TAB + "target : " + param2 + "</span>\n";
      }
      
      private function displayInteractionMessage(param1:Message, param2:DisplayObject) : void {
         var _loc6_:Array = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         this.type = TYPE_UI;
         var _loc3_:String = getQualifiedClassName(param1);
         if(_loc3_.indexOf("::") != -1)
         {
            _loc3_ = _loc3_.split("::")[1];
         }
         this.name = _loc3_;
         var _loc4_:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'green\'> UI     : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "\n<span class=\'gray+\'>" + TAB + "target : " + param2.name + "</span><span class=\'gray\'>";
         var _loc5_:String = String(param1);
         if(_loc5_.indexOf("@") != -1)
         {
            _loc6_ = _loc5_.split("@");
            _loc7_ = _loc6_.length;
            _loc8_ = 1;
            while(_loc8_ < _loc7_)
            {
               _loc4_ = _loc4_ + ("\n" + TAB + _loc6_[_loc8_]);
               _loc8_++;
            }
         }
         this.textInfo = _loc4_ + "</span>\n";
      }
      
      private var vectorExp:RegExp;
      
      private function displayHookInformations(param1:Hook, param2:Array) : void {
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         this.type = TYPE_HOOK;
         this.name = param1.name;
         var _loc3_:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'blue\'> HOOK   : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "<span class=\'gray\'>";
         var _loc4_:int = param2.length;
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param2[_loc5_];
            _loc7_ = getQualifiedClassName(_loc6_);
            _loc7_ = _loc7_.replace(this.vectorExp,"Vector.<$2>");
            _loc7_ = _loc7_.replace(this.search1,"&lt;");
            _loc7_ = _loc7_.replace(this.search2,"&gt;");
            if(_loc7_.indexOf("::") != -1)
            {
               _loc7_ = _loc7_.split("::")[1];
            }
            if(_loc6_ != null)
            {
               _loc8_ = _loc6_.toString();
               _loc8_ = _loc8_.replace(this.search1,"&lt;");
               _loc8_ = _loc8_.replace(this.search2,"&gt;");
            }
            _loc3_ = _loc3_ + ("\n" + TAB + "arg" + _loc5_ + ":" + _loc7_ + " = " + _loc8_);
            _loc5_++;
         }
         _loc3_ = _loc3_ + "</span>\n";
         this.textInfo = _loc3_;
      }
      
      private function displayLog(param1:String, param2:int) : void {
         var _loc3_:String = null;
         this.name = param1;
         if(param2 == LogLevel.DEBUG)
         {
            _loc3_ = "<span class=\'blue\'>";
         }
         else
         {
            if(param2 == LogLevel.TRACE)
            {
               _loc3_ = "<span class=\'green\'>";
            }
            else
            {
               if(param2 == LogLevel.INFO)
               {
                  _loc3_ = "<span class=\'yellow\'>";
               }
               else
               {
                  if(param2 == LogLevel.WARN)
                  {
                     _loc3_ = "<span class=\'orange\'>";
                  }
                  else
                  {
                     if(param2 == LogLevel.ERROR)
                     {
                        _loc3_ = "<span class=\'red\'>";
                     }
                     else
                     {
                        if(param2 == LogLevel.FATAL)
                        {
                           _loc3_ = "<span class=\'red+\'>";
                        }
                        else
                        {
                           if(param2 == LOG_CHAT)
                           {
                              this.logType = LOG_CHAT;
                              _loc3_ = "<span class=\'white\'>";
                           }
                           else
                           {
                              _loc3_ = "<span class=\'gray\'>";
                           }
                        }
                     }
                  }
               }
            }
         }
         _loc3_ = _loc3_ + ("[" + this.getDate() + "] " + param1 + "</span>");
         this.textInfo = _loc3_;
      }
      
      private function displayActionInformations(param1:Action) : void {
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         this.type = TYPE_ACTION;
         var _loc2_:String = getQualifiedClassName(param1).split("::")[1];
         this.name = _loc2_;
         var _loc3_:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'pink\'> ACTION : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "<span class=\'gray\'>";
         var _loc4_:XML = describeType(param1);
         var _loc5_:XMLList = _loc4_.elements("variable");
         for each (_loc6_ in _loc5_)
         {
            _loc7_ = _loc6_.attribute("name");
            _loc8_ = _loc6_.attribute("type");
            _loc8_ = _loc8_.replace(this.search1,"&lt;");
            _loc8_ = _loc8_.replace(this.search2,"&gt;");
            _loc9_ = String(param1[_loc7_]);
            _loc9_ = _loc9_.replace(this.search1,"&lt;");
            _loc9_ = _loc9_.replace(this.search2,"&gt;");
            _loc3_ = _loc3_ + ("\n" + TAB + _loc7_ + ":" + _loc8_ + " = " + _loc9_);
         }
         _loc3_ = _loc3_ + "</span>\n";
         this.textInfo = _loc3_;
      }
      
      private function getDate() : String {
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.hours;
         var _loc3_:int = _loc1_.minutes;
         var _loc4_:int = _loc1_.seconds;
         return (_loc2_ < 10?"0" + _loc2_:_loc2_) + ":" + (_loc3_ < 10?"0" + _loc3_:_loc3_) + ":" + (_loc4_ < 10?"0" + _loc4_:_loc4_);
      }
   }
}
