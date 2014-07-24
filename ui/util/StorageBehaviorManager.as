package util
{
   import ui.behavior.IStorageBehavior;
   import ui.behavior.BankBehavior;
   import ui.behavior.TaxCollectorBehavior;
   import ui.behavior.BidHouseBehavior;
   import ui.behavior.CraftBehavior;
   import ui.behavior.DecraftBehavior;
   import ui.behavior.ExchangeBehavior;
   import ui.behavior.ExchangeNPCBehavior;
   import ui.behavior.HumanVendorBehavior;
   import ui.behavior.MyselfVendorBehavior;
   import ui.behavior.ShopBehavior;
   import ui.behavior.SmithMagicBehavior;
   import ui.behavior.SmithMagicCoopBehavior;
   import ui.behavior.StorageClassicBehavior;
   import ui.behavior.BankUiBehavior;
   import ui.behavior.MountBehavior;
   import ui.behavior.TokenShopBehavior;
   import ui.behavior.TokenStoneShopBehavior;
   import ui.behavior.MimicryBehavior;
   import ui.enum.StorageState;
   
   public class StorageBehaviorManager extends Object
   {
      
      public function StorageBehaviorManager() {
         super();
      }
      
      public static function makeBehavior(behaviorName:String) : IStorageBehavior {
         switch(behaviorName)
         {
            case StorageState.BANK_MOD:
               return new BankBehavior();
            case StorageState.TAXCOLLECTOR_MOD:
               return new TaxCollectorBehavior();
            case StorageState.BID_HOUSE_MOD:
               return new BidHouseBehavior();
            case StorageState.CRAFT_MOD:
               return new CraftBehavior();
            case StorageState.DECRAFT_MOD:
               return new DecraftBehavior();
            case StorageState.EXCHANGE_MOD:
               return new ExchangeBehavior();
            case StorageState.EXCHANGE_NPC_MOD:
               return new ExchangeNPCBehavior();
            case StorageState.HUMAN_VENDOR_MOD:
               return new HumanVendorBehavior();
            case StorageState.MYSELF_VENDOR_MOD:
               return new MyselfVendorBehavior();
            case StorageState.SHOP_MOD:
               return new ShopBehavior();
            case StorageState.SMITH_MAGIC_MOD:
               return new SmithMagicBehavior();
            case StorageState.SMITH_MAGIC_COOP_MOD:
               return new SmithMagicCoopBehavior();
            case StorageState.BAG_MOD:
               return new StorageClassicBehavior();
            case StorageState.BANK_UI_MOD:
               return new BankUiBehavior();
            case StorageState.MOUNT_MOD:
               return new MountBehavior();
            case StorageState.TOKEN_SHOP_MOD:
               return new TokenShopBehavior();
            case StorageState.TOKEN_STONE_SHOP_MOD:
               return new TokenStoneShopBehavior();
            case StorageState.MIMICRY_MOD:
               return new MimicryBehavior();
            default:
               throw new Error("Invalid behavior : " + behaviorName);
         }
      }
   }
}
