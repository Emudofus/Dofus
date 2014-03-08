package com.ankamagames.berilia.utils
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class BeriliaHookList extends Object
   {
      
      public function BeriliaHookList() {
         super();
      }
      
      public static const MouseClick:Hook = new Hook("MouseClick",false);
      
      public static const MouseMiddleClick:Hook = new Hook("MouseMiddleClick",false);
      
      public static const MouseShiftClick:Hook = new Hook("MouseShiftClick",false);
      
      public static const MouseCtrlClick:Hook = new Hook("MouseCtrlClick",false);
      
      public static const MouseAltClick:Hook = new Hook("MouseAltClick",false);
      
      public static const MouseCtrlDoubleClick:Hook = new Hook("MouseCtrlDoubleClick",false);
      
      public static const MouseAltDoubleClick:Hook = new Hook("MouseAltDoubleClick",false);
      
      public static const PostMouseClick:Hook = new Hook("PostMouseClick",false);
      
      public static const KeyUp:Hook = new Hook("KeyUp",false);
      
      public static const DropStart:Hook = new Hook("DropStart",false);
      
      public static const DropEnd:Hook = new Hook("DropEnd",false);
      
      public static const KeyboardShortcut:Hook = new Hook("KeyboardShortcut",true);
      
      public static const ShortcutUpdate:Hook = new Hook("ShortcutUpdate",true);
      
      public static const TextureLoadFailed:Hook = new Hook("TextureLoadFailed",false);
      
      public static const SlotDropedOnBerilia:Hook = new Hook("SlotDropedOnBerilia",false);
      
      public static const SlotDropedOnWorld:Hook = new Hook("SlotDropedOnWorld",false);
      
      public static const SlotDropedNorBeriliaNorWorld:Hook = new Hook("SlotDropedNorBeriliaNorWorld",false);
      
      public static const UiLoaded:Hook = new Hook("UiLoaded",false);
      
      public static const ChatHyperlink:Hook = new Hook("ChatHyperlink",true);
      
      public static const ChatRollOverLink:Hook = new Hook("ChatRollOverLink",true);
      
      public static const UiUnloading:Hook = new Hook("UiUnloading",false);
      
      public static const UiUnloaded:Hook = new Hook("UiUnloaded",false);
      
      public static const WindowResize:Hook = new Hook("WindowResize",false);
   }
}
