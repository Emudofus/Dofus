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
      
      public function TypeMessage(... args) {
         var object:Object = null;
         this.search1 = new RegExp("<","g");
         this.search2 = new RegExp(">","g");
         this.vectorExp = new RegExp("Vector.<(.*)::(.*)>","g");
         super();
         try
         {
            object = args[0];
            if((object is String) && (args.length == 2))
            {
               this.displayLog(object as String,args[1]);
            }
            else if(object is Hook)
            {
               this.displayHookInformations(object as Hook,args[1]);
            }
            else if(object is Action)
            {
               this.displayActionInformations(object as Action);
            }
            else if(object is Message)
            {
               this.displayInteractionMessage(object as Message,args[1]);
            }
            else if(object is Bind)
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
         catch(e:Error)
         {
            if(!(object is String))
            {
               name = "trace";
               textInfo = "<span class=\'red\'>" + e.getStackTrace() + "</span>";
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
      
      private function displayBind(bind:Bind, ui:Object) : void {
         this.type = TYPE_SHORTCUT;
         var textBind:String = "Shortcut : " + bind.key.toUpperCase() + " --&gt; \"" + bind.targetedShortcut + "\" " + (bind.alt?"Alt+":"") + (bind.ctrl?"Ctrl+":"") + (bind.shift?"Shift+":"");
         this.name = "Shortcut";
         this.textInfo = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'yellow\'> BIND   : <a href=\'event:@shortcut\'>" + textBind + "</a></span>" + "\n<span class=\'gray+\'>" + TAB + "target : " + ui + "</span>\n";
      }
      
      private function displayInteractionMessage(msg:Message, ui:DisplayObject) : void {
         var infos:Array = null;
         var num:* = 0;
         var i:* = 0;
         this.type = TYPE_UI;
         var className:String = getQualifiedClassName(msg);
         if(className.indexOf("::") != -1)
         {
            className = className.split("::")[1];
         }
         this.name = className;
         var text:String = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'green\'> UI     : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "\n<span class=\'gray+\'>" + TAB + "target : " + ui.name + "</span><span class=\'gray\'>";
         var baseName:String = String(msg);
         if(baseName.indexOf("@") != -1)
         {
            infos = baseName.split("@");
            num = infos.length;
            i = 1;
            while(i < num)
            {
               text = text + ("\n" + TAB + infos[i]);
               i++;
            }
         }
         this.textInfo = text + "</span>\n";
      }
      
      private var vectorExp:RegExp;
      
      private function displayHookInformations(hook:Hook, args:Array) : void {
         var arg:Object = null;
         var className:String = null;
         var textArg:String = null;
         this.type = TYPE_HOOK;
         this.name = hook.name;
         var text:String = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'blue\'> HOOK   : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "<span class=\'gray\'>";
         var num:int = args.length;
         var i:int = 0;
         while(i < num)
         {
            arg = args[i];
            className = getQualifiedClassName(arg);
            className = className.replace(this.vectorExp,"Vector.<$2>");
            className = className.replace(this.search1,"&lt;");
            className = className.replace(this.search2,"&gt;");
            if(className.indexOf("::") != -1)
            {
               className = className.split("::")[1];
            }
            if(arg != null)
            {
               textArg = arg.toString();
               textArg = textArg.replace(this.search1,"&lt;");
               textArg = textArg.replace(this.search2,"&gt;");
            }
            text = text + ("\n" + TAB + "arg" + i + ":" + className + " = " + textArg);
            i++;
         }
         text = text + "</span>\n";
         this.textInfo = text;
      }
      
      private function displayLog(text:String, level:int) : void {
         var finalText:String = null;
         this.name = text;
         if(level == LogLevel.DEBUG)
         {
            finalText = "<span class=\'blue\'>";
         }
         else if(level == LogLevel.TRACE)
         {
            finalText = "<span class=\'green\'>";
         }
         else if(level == LogLevel.INFO)
         {
            finalText = "<span class=\'yellow\'>";
         }
         else if(level == LogLevel.WARN)
         {
            finalText = "<span class=\'orange\'>";
         }
         else if(level == LogLevel.ERROR)
         {
            finalText = "<span class=\'red\'>";
         }
         else if(level == LogLevel.FATAL)
         {
            finalText = "<span class=\'red+\'>";
         }
         else if(level == LOG_CHAT)
         {
            this.logType = LOG_CHAT;
            finalText = "<span class=\'white\'>";
         }
         else
         {
            finalText = "<span class=\'gray\'>";
         }
         
         
         
         
         
         
         finalText = finalText + ("[" + this.getDate() + "] " + text + "</span>");
         this.textInfo = finalText;
      }
      
      private function displayActionInformations(action:Action) : void {
         var variable:XML = null;
         var name:String = null;
         var typel:String = null;
         var value:String = null;
         this.type = TYPE_ACTION;
         var actionName:String = getQualifiedClassName(action).split("::")[1];
         this.name = actionName;
         var text:String = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'pink\'> ACTION : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "<span class=\'gray\'>";
         var infos:XML = describeType(action);
         var variables:XMLList = infos.elements("variable");
         for each(variable in variables)
         {
            name = variable.attribute("name");
            typel = variable.attribute("type");
            typel = typel.replace(this.search1,"&lt;");
            typel = typel.replace(this.search2,"&gt;");
            value = String(action[name]);
            value = value.replace(this.search1,"&lt;");
            value = value.replace(this.search2,"&gt;");
            text = text + ("\n" + TAB + name + ":" + typel + " = " + value);
         }
         text = text + "</span>\n";
         this.textInfo = text;
      }
      
      private function getDate() : String {
         var date:Date = new Date();
         var hours:int = date.hours;
         var minutes:int = date.minutes;
         var seconds:int = date.seconds;
         return (hours < 10?"0" + hours:hours) + ":" + (minutes < 10?"0" + minutes:minutes) + ":" + (seconds < 10?"0" + seconds:seconds);
      }
   }
}
