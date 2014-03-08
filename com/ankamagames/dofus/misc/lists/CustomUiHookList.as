package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class CustomUiHookList extends Object
   {
      
      public function CustomUiHookList() {
         super();
      }
      
      public static const FoldAll:Hook = new Hook("FoldAll",false);
      
      public static const SpellMovementAllowed:Hook = new Hook("SpellMovementAllowed",false);
      
      public static const ShortcutsMovementAllowed:Hook = new Hook("ShortcutsMovementAllowed",false);
      
      public static const FlagAdded:Hook = new Hook("FlagAdded",false);
      
      public static const FlagRemoved:Hook = new Hook("FlagRemoved",false);
      
      public static const MapHintsFilter:Hook = new Hook("MapHintsFilter",false);
      
      public static const FightResultClosed:Hook = new Hook("FightResultClosed",false);
      
      public static const InsertHyperlink:Hook = new Hook("InsertHyperlink",false);
      
      public static const OpeningContextMenu:Hook = new Hook("OpeningContextMenu",false);
      
      public static const OpenReport:Hook = new Hook("OpenReport",true);
      
      public static const RefreshTips:Hook = new Hook("RefreshTips",false);
      
      public static const SwitchBannerTab:Hook = new Hook("SwitchBannerTab",false);
      
      public static const StopCinematic:Hook = new Hook("StopCinematic",false);
      
      public static const ActivateSound:Hook = new Hook("ActivateSound",false);
      
      public static const StorageFilterUpdated:Hook = new Hook("StorageFilterUpdated",false);
      
      public static const ClosingInventory:Hook = new Hook("ClosingInventory",false);
      
      public static const AddBannerButton:Hook = new Hook("AddBannerButton",false);
      
      public static const ClientUIOpened:Hook = new Hook("ClientUIOpened",false);
   }
}
