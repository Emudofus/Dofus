package ui
{
   import d2actions.*;
   import d2hooks.*;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.MountApi;
   import d2api.BindsApi;
   import d2api.MapApi;
   import d2components.GraphicContainer;
   import d2components.EntityDisplayer;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2components.ComboBox;
   import d2components.Grid;
   import d2components.Input;
   import enums.MountFilterEnum;
   import d2enums.ShortcutHookListEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import d2data.MountData;
   import d2enums.ExchangeHandleMountStableTypeEnum;
   import d2enums.SelectMethodEnum;
   
   public class MountPaddock extends Object
   {
      
      public function MountPaddock() {
         this._barnSortOrder = [
            {
               "type":SORT_TYPE_TYPE,
               "asc":true
            },
            {
               "type":SORT_TYPE_GENDER,
               "asc":true
            },
            {
               "type":SORT_TYPE_NAME,
               "asc":true
            },
            {
               "type":SORT_TYPE_LEVEL,
               "asc":true
            }];
         this._paddockSortOrder = [
            {
               "type":SORT_TYPE_TYPE,
               "asc":true
            },
            {
               "type":SORT_TYPE_GENDER,
               "asc":true
            },
            {
               "type":SORT_TYPE_NAME,
               "asc":true
            },
            {
               "type":SORT_TYPE_LEVEL,
               "asc":true
            }];
         super();
      }
      
      public static const SOURCE_EQUIP:int = 0;
      
      public static const SOURCE_INVENTORY:int = 1;
      
      public static const SOURCE_BARN:int = 2;
      
      public static const SOURCE_PADDOCK:int = 3;
      
      public static const SORT_TYPE_TYPE:int = 0;
      
      public static const SORT_TYPE_GENDER:int = 1;
      
      public static const SORT_TYPE_NAME:int = 2;
      
      public static const SORT_TYPE_LEVEL:int = 3;
      
      public static const SHORTCUT_STOCK:String = "s1";
      
      public static const SHORTCUT_PARK:String = "s2";
      
      public static const SHORTCUT_EXCHANGE:String = "s4";
      
      public static const SHORTCUT_EQUIP:String = "s3";
      
      public static const STABLE_SIZE:int = 250;
      
      public static var _currentSource:int = -2;
      
      private static function switchSort(sortOptions:Array, sortType:int) : void {
         var i:* = 0;
         var se:Object = null;
         if(sortOptions[0].type == sortType)
         {
            sortOptions[0].asc = !sortOptions[0].asc;
         }
         else
         {
            i = 0;
            while(i < sortOptions.length)
            {
               se = sortOptions[i];
               if(se.type == sortType)
               {
                  sortOptions.splice(i,1);
                  break;
               }
               i++;
            }
            se = 
               {
                  "type":sortType,
                  "asc":true
               };
            sortOptions.unshift(se);
         }
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var mountApi:MountApi;
      
      public var bindsApi:BindsApi;
      
      public var modCommon:Object;
      
      public var mapApi:MapApi;
      
      private var _mountInfoUi:Object;
      
      private var _mountInfoUiLoaded:Boolean = false;
      
      private var _mount:Object;
      
      private var _nameless:String;
      
      private var _lastSource:int = -2;
      
      private var _maxOutdoorMount:int;
      
      private var _barnList:Array;
      
      private var _paddockList:Array;
      
      private var _inventoryList:Object;
      
      private var _fullDataProvider:Array;
      
      private var _stableFilters:Array;
      
      private var _stableFilter2:Array;
      
      private var _stableFilter3:Array;
      
      private var _paddockFilters:Array;
      
      private var _barnSortOrder:Array;
      
      private var _paddockSortOrder:Array;
      
      private var _lastSortOptions:Array;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_mountEquiped:GraphicContainer;
      
      public var ed_mount:EntityDisplayer;
      
      public var lbl_title:Label;
      
      public var lbl_mountEquiped:Label;
      
      public var lbl_mountName:Label;
      
      public var lbl_mountDescription:Label;
      
      public var lbl_mountLevel:Label;
      
      public var lbl_park:Label;
      
      public var lbl_certificates:Label;
      
      public var lbl_stock:Label;
      
      public var btn_exchange:ButtonContainer;
      
      public var btn_stock:ButtonContainer;
      
      public var btn_park:ButtonContainer;
      
      public var btn_equip:ButtonContainer;
      
      public var btn_lbl_btn_exchange:Label;
      
      public var btn_lbl_btn_stock:Label;
      
      public var btn_lbl_btn_park:Label;
      
      public var btn_lbl_btn_equip:Label;
      
      public var btn_close:ButtonContainer;
      
      public var tx_bgbtntop:Texture;
      
      public var tx_bgbtnbottom:Texture;
      
      public var cb_barn:ComboBox;
      
      public var cb_barn2:ComboBox;
      
      public var cb_barn3:ComboBox;
      
      public var cb_paddock:ComboBox;
      
      public var cb_inventory:ComboBox;
      
      public var tx_barnTexture:Texture;
      
      public var gd_barn:Grid;
      
      public var gd_paddock:Grid;
      
      public var gd_inventory:Grid;
      
      public var ctr_barn:GraphicContainer;
      
      public var ctr_searchBarn:GraphicContainer;
      
      public var ctr_searchPaddock:GraphicContainer;
      
      public var ctr_searchInventory:GraphicContainer;
      
      public var btn_searchBarn:ButtonContainer;
      
      public var btn_searchPaddock:ButtonContainer;
      
      public var btn_searchInventory:ButtonContainer;
      
      public var lbl_searchBarn:Input;
      
      public var lbl_searchPaddock:Input;
      
      public var lbl_searchInventory:Input;
      
      public var btn_barnType:ButtonContainer;
      
      public var btn_barnGender:ButtonContainer;
      
      public var btn_barnName:ButtonContainer;
      
      public var btn_barnLevel:ButtonContainer;
      
      public var btn_paddockType:ButtonContainer;
      
      public var btn_paddockGender:ButtonContainer;
      
      public var btn_paddockName:ButtonContainer;
      
      public var btn_paddockLevel:ButtonContainer;
      
      public var btn_addFilter:ButtonContainer;
      
      public var btn_removeFilter1:ButtonContainer;
      
      public var btn_removeFilter2:ButtonContainer;
      
      public var btn_removeFilter3:ButtonContainer;
      
      public function main(params:Object) : void {
         this._stableFilters = [
            {
               "label":this.uiApi.getText("ui.common.allTypes"),
               "type":MountFilterEnum.MOUNT_ALL,
               "filterGroup":-1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterMan"),
               "type":MountFilterEnum.MOUNT_MALE,
               "filterGroup":1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterWoman"),
               "type":MountFilterEnum.MOUNT_FEMALE,
               "filterGroup":1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFecondable"),
               "type":MountFilterEnum.MOUNT_FRUITFUL,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNoFecondable"),
               "type":MountFilterEnum.MOUNT_NOFRUITFUL,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterPositiveSerenity"),
               "type":MountFilterEnum.MOUNT_POSITIVE_SERENITY,
               "filterGroup":4
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNegativeSerenity"),
               "type":MountFilterEnum.MOUNT_NEGATIVE_SERENITY,
               "filterGroup":4
            },
            {
               "label":this.uiApi.getText("ui.mount.filterAverageSerenity"),
               "type":MountFilterEnum.MOUNT_AVERAGE_SERENITY,
               "filterGroup":4
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNeedLove"),
               "type":MountFilterEnum.MOUNT_NEED_LOVE,
               "filterGroup":10
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNeedStamina"),
               "type":MountFilterEnum.MOUNT_NEED_STAMINA,
               "filterGroup":7
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNeedEnergy"),
               "type":MountFilterEnum.MOUNT_NEED_ENERGY,
               "filterGroup":9
            },
            {
               "label":this.uiApi.getText("ui.mount.filterImmature"),
               "type":MountFilterEnum.MOUNT_IMMATURE,
               "filterGroup":3
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFullLove"),
               "type":MountFilterEnum.MOUNT_FULL_LOVE,
               "filterGroup":10
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFullStamina"),
               "type":MountFilterEnum.MOUNT_FULL_STAMINA,
               "filterGroup":7
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFecondee"),
               "type":MountFilterEnum.MOUNT_FERTILIZED,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterBorn"),
               "type":MountFilterEnum.MOUNT_BABY,
               "filterGroup":3
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNoName"),
               "type":MountFilterEnum.MOUNT_NAMELESS,
               "filterGroup":-1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterMustXP"),
               "type":MountFilterEnum.MOUNT_TRAINABLE,
               "filterGroup":-1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNoTired"),
               "type":MountFilterEnum.MOUNT_NOTIRED,
               "filterGroup":8
            },
            {
               "label":this.uiApi.getText("ui.mount.filterTired","100%"),
               "type":MountFilterEnum.MOUNT_100_TIRED,
               "filterGroup":8
            },
            {
               "label":this.uiApi.getText("ui.mount.filterTired","&lt;50%"),
               "type":MountFilterEnum.MOUNT_LESS50_TIRED,
               "filterGroup":8
            },
            {
               "label":this.uiApi.getText("ui.mount.filterTired",">50%"),
               "type":MountFilterEnum.MOUNT_MORE50_TIRED,
               "filterGroup":8
            },
            {
               "label":this.uiApi.getText("ui.mount.filterSterilized"),
               "type":MountFilterEnum.MOUNT_STERILIZED,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFullEnergy"),
               "type":MountFilterEnum.MOUNT_FULL_ENERGY,
               "filterGroup":9
            },
            {
               "label":this.uiApi.getText("ui.mount.filterMountable"),
               "type":MountFilterEnum.MOUNT_MOUNTABLE,
               "filterGroup":3
            },
            {
               "label":this.uiApi.getText("ui.mount.filterCapacity"),
               "type":MountFilterEnum.MOUNT_SPECIAL,
               "filterGroup":-1
            }];
         this._paddockFilters = [
            {
               "label":this.uiApi.getText("ui.common.allTypes"),
               "type":MountFilterEnum.MOUNT_ALL,
               "filterGroup":-1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterMan"),
               "type":MountFilterEnum.MOUNT_MALE,
               "filterGroup":1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterWoman"),
               "type":MountFilterEnum.MOUNT_FEMALE,
               "filterGroup":1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFecondable"),
               "type":MountFilterEnum.MOUNT_FRUITFUL,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNoFecondable"),
               "type":MountFilterEnum.MOUNT_NOFRUITFUL,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterPositiveSerenity"),
               "type":MountFilterEnum.MOUNT_POSITIVE_SERENITY,
               "filterGroup":4
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNegativeSerenity"),
               "type":MountFilterEnum.MOUNT_NEGATIVE_SERENITY,
               "filterGroup":4
            },
            {
               "label":this.uiApi.getText("ui.mount.filterAverageSerenity"),
               "type":MountFilterEnum.MOUNT_AVERAGE_SERENITY,
               "filterGroup":4
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNeedLove"),
               "type":MountFilterEnum.MOUNT_NEED_LOVE,
               "filterGroup":10
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNeedStamina"),
               "type":MountFilterEnum.MOUNT_NEED_STAMINA,
               "filterGroup":7
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNeedEnergy"),
               "type":MountFilterEnum.MOUNT_NEED_ENERGY,
               "filterGroup":9
            },
            {
               "label":this.uiApi.getText("ui.mount.filterImmature"),
               "type":MountFilterEnum.MOUNT_IMMATURE,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFullLove"),
               "type":MountFilterEnum.MOUNT_FULL_LOVE,
               "filterGroup":10
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFullStamina"),
               "type":MountFilterEnum.MOUNT_FULL_STAMINA,
               "filterGroup":7
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFecondee"),
               "type":MountFilterEnum.MOUNT_FERTILIZED,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterBorn"),
               "type":MountFilterEnum.MOUNT_BABY,
               "filterGroup":3
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNoName"),
               "type":MountFilterEnum.MOUNT_NAMELESS,
               "filterGroup":-1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterMustXP"),
               "type":MountFilterEnum.MOUNT_TRAINABLE,
               "filterGroup":-1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterNoTired"),
               "type":MountFilterEnum.MOUNT_NOTIRED,
               "filterGroup":8
            },
            {
               "label":this.uiApi.getText("ui.mount.filterTired","100%"),
               "type":MountFilterEnum.MOUNT_100_TIRED,
               "filterGroup":8
            },
            {
               "label":this.uiApi.getText("ui.mount.filterTired","&lt;50%"),
               "type":MountFilterEnum.MOUNT_LESS50_TIRED,
               "filterGroup":8
            },
            {
               "label":this.uiApi.getText("ui.mount.filterTired",">50%"),
               "type":MountFilterEnum.MOUNT_MORE50_TIRED,
               "filterGroup":8
            },
            {
               "label":this.uiApi.getText("ui.mount.filterSterilized"),
               "type":MountFilterEnum.MOUNT_STERILIZED,
               "filterGroup":2
            },
            {
               "label":this.uiApi.getText("ui.mount.filterFullEnergy"),
               "type":MountFilterEnum.MOUNT_FULL_ENERGY,
               "filterGroup":9
            },
            {
               "label":this.uiApi.getText("ui.mount.filterMountable"),
               "type":MountFilterEnum.MOUNT_MOUNTABLE,
               "filterGroup":3
            },
            {
               "label":this.uiApi.getText("ui.mount.filterCapacity"),
               "type":MountFilterEnum.MOUNT_SPECIAL,
               "filterGroup":-1
            },
            {
               "label":this.uiApi.getText("ui.mount.filterOwner"),
               "type":MountFilterEnum.MOUNT_OWNER,
               "filterGroup":-1
            }];
         this.sysApi.addHook(MountStableUpdate,this.onMountStableUpdate);
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.sysApi.addHook(MountSet,this.showPlayerMountInfo);
         this.sysApi.addHook(MountUnSet,this.showPlayerMountInfo);
         this.sysApi.addHook(CertificateMountData,this.onCertificateMountData);
         this.sysApi.addHook(MountRenamed,this.onMountRenamed);
         this.sysApi.addHook(MountReleased,this.onMountReleased);
         this.uiApi.addComponentHook(this.btn_exchange,"onRelease");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_stock,"onRelease");
         this.uiApi.addComponentHook(this.btn_park,"onRelease");
         this.uiApi.addComponentHook(this.btn_equip,"onRelease");
         this.uiApi.addComponentHook(this.gd_barn,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_paddock,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_inventory,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_barn,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_barn2,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_barn3,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_paddock,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_inventory,"onSelectItem");
         this.uiApi.addComponentHook(this.btn_searchBarn,"onRelease");
         this.uiApi.addComponentHook(this.btn_searchPaddock,"onRelease");
         this.uiApi.addComponentHook(this.btn_searchInventory,"onRelease");
         this.uiApi.addComponentHook(this.ctr_mountEquiped,"onRelease");
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.uiApi.addShortcutHook(SHORTCUT_EQUIP,this.onShortCut);
         this.uiApi.addShortcutHook(SHORTCUT_EXCHANGE,this.onShortCut);
         this.uiApi.addShortcutHook(SHORTCUT_PARK,this.onShortCut);
         this.uiApi.addShortcutHook(SHORTCUT_STOCK,this.onShortCut);
         this.uiApi.hideTooltip();
         this.btn_lbl_btn_equip.text = this.btn_lbl_btn_equip.text + (" (" + this.bindsApi.getShortcutBindStr(SHORTCUT_EQUIP) + ")");
         this.btn_lbl_btn_exchange.text = this.btn_lbl_btn_exchange.text + (" (" + this.bindsApi.getShortcutBindStr(SHORTCUT_EXCHANGE) + ")");
         this.btn_lbl_btn_park.text = this.btn_lbl_btn_park.text + (" (" + this.bindsApi.getShortcutBindStr(SHORTCUT_PARK) + ")");
         this.btn_lbl_btn_stock.text = this.btn_lbl_btn_stock.text + (" (" + this.bindsApi.getShortcutBindStr(SHORTCUT_STOCK) + ")");
         this._nameless = this.uiApi.getText("ui.common.noName");
         this.cb_barn.visible = true;
         this.cb_barn2.visible = false;
         this.cb_barn3.visible = false;
         this.btn_removeFilter1.visible = false;
         this.btn_removeFilter2.visible = false;
         this.btn_removeFilter3.visible = false;
         this.showUi(params.stabledList,params.paddockedList);
      }
      
      public function get visible() : Boolean {
         return this.mainCtr.visible;
      }
      
      public function hideUi() : void {
         this.sysApi.enableWorldInteraction();
         this.mainCtr.visible = false;
         this._mountInfoUi.visible = false;
         this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
         this._mountInfoUiLoaded = false;
         this.sysApi.sendAction(new LeaveExchangeMount());
      }
      
      public function showUi(stabledList:Object, paddockedList:Object) : void {
         var ele:MountData = null;
         var cb1:* = 0;
         var cb2:* = 0;
         var cb3:* = 0;
         this.sysApi.disableWorldInteraction();
         this.mainCtr.visible = true;
         this.sysApi.addHook(UiLoaded,this.onUiLoaded);
         this._mountInfoUi = this.uiApi.loadUi(UIEnum.MOUNT_INFO,UIEnum.MOUNT_INFO,
            {
               "mount":null,
               "paddockMode":true,
               "posX":458,
               "posY":97
            });
         this._mountInfoUi.visible = false;
         this.showPlayerMountInfo();
         this.sourceSelected(-1);
         this.lbl_searchBarn.text = "";
         this.lbl_searchPaddock.text = "";
         this.lbl_searchInventory.text = "";
         this._barnList = new Array();
         for each(ele in stabledList)
         {
            this._barnList.push(ele);
         }
         this._paddockList = new Array();
         for each(ele in paddockedList)
         {
            this._paddockList.push(ele);
         }
         this._inventoryList = this.mountApi.getInventoryList();
         this.updateBarnFilter();
         cb1 = MountFilterEnum.MOUNT_ALL;
         cb2 = MountFilterEnum.MOUNT_ALL;
         cb3 = MountFilterEnum.MOUNT_ALL;
         if(this.cb_barn.value)
         {
            cb1 = this.cb_barn.value.type;
         }
         if(this.cb_barn.value)
         {
            cb2 = this.cb_barn2.value.type;
         }
         if(this.cb_barn.value)
         {
            cb3 = this.cb_barn3.value.type;
         }
         this.updateBarn(cb1,cb2,cb3);
         this.updatePaddockFilter();
         var padFilter:int = MountFilterEnum.MOUNT_ALL;
         if(this.cb_paddock.value)
         {
            padFilter = this.cb_paddock.value;
         }
         this.updatePaddock(padFilter);
         this.updateInventoryFilter();
         var invFilter:String = "";
         if(this.cb_inventory.value)
         {
            invFilter = this.cb_inventory.value;
         }
         this.updateInventory(invFilter);
         this._maxOutdoorMount = this.mountApi.getCurrentPaddock().maxOutdoorMount;
         this.lbl_title.text = this.mapApi.getCurrentSubArea().name;
      }
      
      public function showMountInfo(mount:Object, source:int) : void {
         if(mount)
         {
            this._mount = mount;
            _currentSource = source;
            this._mountInfoUi.visible = true;
            if((this._mount) && (this._mountInfoUiLoaded) && (this._mountInfoUi))
            {
               this._mountInfoUi.uiClass.showMountInformation(mount,source);
            }
         }
      }
      
      public function showPlayerMountInfo() : void {
         var playerMount:Object = this.playerApi.getMount();
         if(playerMount)
         {
            this.lbl_mountEquiped.text = this.uiApi.getText("ui.mount.playerMount");
            this.lbl_mountName.text = playerMount.name;
            this.lbl_mountDescription.text = playerMount.description;
            this.lbl_mountLevel.text = this.uiApi.getText("ui.common.level") + this.uiApi.getText("ui.common.colon") + playerMount.level;
            this.ed_mount.look = playerMount.entityLook;
         }
         else
         {
            this.lbl_mountEquiped.text = this.uiApi.getText("ui.mount.noPlayerMount");
            this.lbl_mountName.text = "";
            this.lbl_mountDescription.text = "";
            this.lbl_mountLevel.text = "";
            this.ed_mount.look = null;
         }
      }
      
      public function showCurrentMountInfo() : void {
         if(this.playerApi.getMount())
         {
            this.gd_paddock.selectedIndex = -1;
            this.gd_barn.selectedIndex = -1;
            this.gd_inventory.selectedIndex = -1;
            this.showMountInfo(this.playerApi.getMount(),0);
            this.sourceSelected(SOURCE_EQUIP);
         }
      }
      
      public function unload() : void {
         if(this.uiApi.getUi(UIEnum.MOUNT_INFO))
         {
            this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
         }
      }
      
      private function sourceSelected(source:int) : void {
         if(this._lastSource != source)
         {
            this._lastSource = source;
            _currentSource = source;
            if(source == SOURCE_BARN)
            {
               this.gd_barn.autoSelectMode = 1;
               this.gd_inventory.autoSelectMode = 0;
               this.gd_paddock.autoSelectMode = 0;
            }
            else if(source == SOURCE_INVENTORY)
            {
               this.gd_barn.autoSelectMode = 0;
               this.gd_inventory.autoSelectMode = 1;
               this.gd_paddock.autoSelectMode = 0;
            }
            else if(source == SOURCE_PADDOCK)
            {
               this.gd_barn.autoSelectMode = 0;
               this.gd_inventory.autoSelectMode = 0;
               this.gd_paddock.autoSelectMode = 1;
            }
            
            
            if(source == -1)
            {
               this._mount = null;
               this.btn_exchange.visible = false;
               this.btn_stock.visible = false;
               this.btn_park.visible = false;
               this.btn_equip.visible = false;
               this.tx_bgbtntop.visible = false;
               this.tx_bgbtnbottom.visible = false;
               this._mountInfoUi.visible = false;
            }
            else
            {
               this._mountInfoUi.visible = true;
               this.btn_exchange.visible = true;
               this.btn_stock.visible = true;
               this.btn_park.visible = true;
               this.btn_equip.visible = true;
               this.tx_bgbtntop.visible = true;
               this.tx_bgbtnbottom.visible = true;
               if(source == 0)
               {
                  this.btn_exchange.disabled = false;
                  this.btn_stock.disabled = false;
                  this.btn_park.disabled = false;
                  this.btn_equip.disabled = true;
               }
               else if(source == 1)
               {
                  this.btn_exchange.disabled = true;
                  this.btn_stock.disabled = false;
                  this.btn_park.disabled = false;
                  this.btn_equip.disabled = false;
               }
               else if(source == 2)
               {
                  this.btn_exchange.disabled = false;
                  this.btn_stock.disabled = true;
                  this.btn_park.disabled = false;
                  this.btn_equip.disabled = false;
               }
               else if(source == 3)
               {
                  this.btn_exchange.disabled = false;
                  this.btn_stock.disabled = false;
                  this.btn_park.disabled = true;
                  this.btn_equip.disabled = false;
               }
               
               
               
            }
         }
      }
      
      private function updateBarnFilter() : void {
         var i:* = 0;
         var currentSelection:* = undefined;
         var barnCB:Array = this._stableFilters.slice();
         var nb:int = this._barnList.length;
         barnCB = this.getPertinentFilter(barnCB);
         var capacityAndModel:Array = this.getCapacityAndModelFilterInBarn(this._barnList);
         barnCB = barnCB.concat(capacityAndModel);
         if(this.cb_barn.value)
         {
            currentSelection = this.cb_barn.value;
            this.cb_barn.dataProvider = barnCB;
            nb = barnCB.length;
            i = 0;
            while(i < nb)
            {
               if(barnCB[i].label == currentSelection.label)
               {
                  this.cb_barn.selectedIndex = i;
                  break;
               }
               i++;
            }
         }
         else
         {
            this.cb_barn.dataProvider = barnCB;
         }
         if(this.cb_barn2.value)
         {
            currentSelection = this.cb_barn2.value;
            this._stableFilter2 = this.createBarnCb(this.cb_barn.value.filterGroup,this._fullDataProvider,this.cb_barn2);
            this.cb_barn2.dataProvider = this._stableFilter2;
            if((!(currentSelection.filterGroup == -1)) && ((currentSelection == this.cb_barn.value) || (currentSelection.filterGroup == this.cb_barn.value.filterGroup)))
            {
               this.cb_barn2.selectedIndex = 0;
            }
            else
            {
               nb = this._stableFilter2.length;
               i = 0;
               while(i < nb)
               {
                  if(this._stableFilter2[i].label == currentSelection.label)
                  {
                     this.cb_barn2.selectedIndex = i;
                     break;
                  }
                  i++;
               }
            }
         }
         else
         {
            this.cb_barn2.dataProvider = barnCB;
            this.cb_barn2.selectedIndex = 0;
         }
         if(this.cb_barn3.value)
         {
            currentSelection = this.cb_barn3.value;
            this._stableFilter3 = this.createBarnCb(this.cb_barn2.value.filterGroup,this._stableFilter2,this.cb_barn3);
            this.cb_barn3.dataProvider = this._stableFilter3;
            if((!(currentSelection.filterGroup == -1)) && ((currentSelection == this.cb_barn.value) || (currentSelection.filterGroup == this.cb_barn.value.filterGroup) || (currentSelection == this.cb_barn2.value) || (currentSelection.filterGroup == this.cb_barn2.value.filterGroup)))
            {
               this.cb_barn3.selectedIndex = 0;
            }
            else
            {
               nb = this._stableFilter3.length;
               i = 0;
               while(i < nb)
               {
                  if(this._stableFilter3[i].label == currentSelection.label)
                  {
                     this.cb_barn3.selectedIndex = i;
                     break;
                  }
                  i++;
               }
            }
         }
         else
         {
            this.cb_barn3.dataProvider = barnCB;
            this.cb_barn3.selectedIndex = 0;
         }
         this._fullDataProvider = barnCB;
      }
      
      private function getPertinentFilter(dataProvider:Array, mountList:* = null, comboBoxRequester:ComboBox = null) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function createBarnCb(groupType:int, barnCB:Array, cbRequester:ComboBox) : Array {
         var mount:* = undefined;
         var value:* = undefined;
         var mountList:* = this.gd_barn.dataProvider;
         var capacityAndModel:Array = new Array();
         mountList = new Array();
         if(cbRequester == this.cb_barn2)
         {
            for each(mount in this._barnList)
            {
               if(this.mountFilteredBy(mount,this.cb_barn.value.type))
               {
                  mountList.push(mount);
               }
            }
         }
         else if(cbRequester == this.cb_barn3)
         {
            for each(mount in this._barnList)
            {
               if(this.mountFilter(mount,this.cb_barn.value.type,this.cb_barn2.value.type,MountFilterEnum.MOUNT_ALL,null))
               {
                  mountList.push(mount);
               }
            }
         }
         
         var newCB:Array = new Array();
         for each(value in barnCB)
         {
            if((value.filterGroup == -1) || (!(value.filterGroup as int == groupType)) && (!(value.filterGroup as int == 6)) && (!(value.filterGroup as int == 5)))
            {
               newCB.push(value);
            }
         }
         var barnCB:Array = newCB;
         if(cbRequester)
         {
            capacityAndModel = this.getCapacityAndModelFilterInBarn(mountList,false,cbRequester);
         }
         barnCB = this.getPertinentFilter(barnCB,mountList,cbRequester);
         barnCB = barnCB.concat(capacityAndModel);
         return barnCB;
      }
      
      private function getCapacityAndModelFilterInBarn(dataProvider:*, checkSubFilter:Boolean = false, comboBoxRequester:ComboBox = null) : Array {
         var i:* = 0;
         var mount:Object = null;
         var nCapacity:* = 0;
         var j:* = 0;
         var nb:int = dataProvider.length;
         var modeleAdded:Array = new Array();
         var capacityAdded:Array = new Array();
         if(checkSubFilter)
         {
            if((this.cb_barn) && (this.cb_barn.value.filterGroup == 6))
            {
               capacityAdded.push(this.cb_barn.value.type);
            }
            if(this.cb_barn2)
            {
               if(this.cb_barn2.value.filterGroup == 6)
               {
                  capacityAdded.push(this.cb_barn2.value.type);
               }
               else if(this.cb_barn2.value.filterGroup == 5)
               {
                  modeleAdded.push(this.cb_barn2.value.type);
               }
               
            }
         }
         var modelToAdd:Array = new Array();
         var capacityToAdd:Array = new Array();
         if(comboBoxRequester)
         {
            if(comboBoxRequester.value.filterGroup == 6)
            {
               capacityAdded.push(comboBoxRequester.value.type);
               capacityToAdd.push(comboBoxRequester.value);
            }
            else if(comboBoxRequester.value.filterGroup == 5)
            {
               modeleAdded.push(comboBoxRequester.value.type);
               modelToAdd.push(comboBoxRequester.value);
            }
            
         }
         i = 0;
         while(i < nb)
         {
            mount = dataProvider[i];
            if(modeleAdded.indexOf(-mount.model) == -1)
            {
               modeleAdded.push(-mount.model);
               modelToAdd.push(
                  {
                     "label":mount.description,
                     "type":-mount.model,
                     "filterGroup":5
                  });
            }
            nCapacity = mount.ability.length;
            if(nCapacity)
            {
               j = 0;
               while(j < nCapacity)
               {
                  if(capacityAdded.indexOf(100 + mount.ability[j].id) == -1)
                  {
                     capacityAdded.push(100 + mount.ability[j].id);
                     capacityToAdd.push(
                        {
                           "label":mount.ability[j].name,
                           "type":100 + mount.ability[j].id,
                           "filterGroup":6
                        });
                  }
                  j++;
               }
            }
            i++;
         }
         return capacityToAdd.concat(modelToAdd);
      }
      
      private function updateBarn(filterType:int, filterType2:int, filterType3:int) : void {
         var mount:MountData = null;
         var textFilter:String = this.lbl_searchBarn.text;
         var gridProvider:Array = new Array();
         if((this._barnList.length == 0) && (_currentSource == SOURCE_BARN))
         {
            this.sourceSelected(-1);
         }
         var nb:int = this._barnList.length;
         var i:int = 0;
         while(i < nb)
         {
            mount = this._barnList[i];
            if(this.mountFilter(mount,filterType,filterType2,filterType3,textFilter))
            {
               gridProvider.push(mount);
            }
            i++;
         }
         this.applySort(gridProvider,this._barnSortOrder);
         this.gd_barn.dataProvider = gridProvider;
         this.updateBarnFilter();
         this.lbl_stock.text = this.uiApi.getText("ui.mount.numMountBarn",gridProvider.length + "/" + STABLE_SIZE);
      }
      
      private function updatePaddockFilter() : void {
         var mount:MountData = null;
         var nCapacity:* = 0;
         var j:* = 0;
         var currentSelection:String = null;
         var k:* = 0;
         var modeleAdded:Array = new Array();
         var capacityAdded:Array = new Array();
         var paddockCB:Array = this._paddockFilters.slice();
         var nb:int = this._paddockList.length;
         var i:int = 0;
         while(i < nb)
         {
            mount = this._paddockList[i];
            if(modeleAdded.indexOf(mount.model) == -1)
            {
               modeleAdded.push(mount.model);
               paddockCB.push(
                  {
                     "label":mount.description,
                     "type":-mount.model
                  });
            }
            nCapacity = mount.ability.length;
            if(nCapacity)
            {
               j = 0;
               while(j < nCapacity)
               {
                  if(capacityAdded.indexOf(mount.ability[j].id) == -1)
                  {
                     capacityAdded.push(mount.ability[j].id);
                     paddockCB.push(
                        {
                           "label":mount.ability[j].name,
                           "type":100 + mount.ability[j].id
                        });
                  }
                  j++;
               }
            }
            i++;
         }
         if(this.cb_paddock.value)
         {
            currentSelection = this.cb_paddock.value.label;
            nb = paddockCB.length;
            k = 0;
            while(k < nb)
            {
               if(paddockCB[k].label == currentSelection)
               {
                  break;
               }
               k++;
            }
            this.cb_paddock.dataProvider = paddockCB;
         }
         else
         {
            this.cb_paddock.dataProvider = paddockCB;
         }
      }
      
      private function updatePaddock(filterType:int) : void {
         var mount:MountData = null;
         var textFilter:String = this.lbl_searchPaddock.text;
         var gridProvider:Array = new Array();
         if((this._paddockList.length == 0) && (_currentSource == SOURCE_PADDOCK))
         {
            this.sourceSelected(-1);
         }
         var nb:int = this._paddockList.length;
         var i:int = 0;
         while(i < nb)
         {
            mount = this._paddockList[i];
            if(this.mountFilter(mount,filterType,MountFilterEnum.MOUNT_ALL,MountFilterEnum.MOUNT_ALL,textFilter))
            {
               gridProvider.push(mount);
            }
            i++;
         }
         this.applySort(gridProvider,this._paddockSortOrder);
         this.gd_paddock.dataProvider = gridProvider;
         this.lbl_park.text = this.uiApi.getText("ui.mount.numMountPaddock",gridProvider.length + "/" + this._maxOutdoorMount);
      }
      
      private function updateInventoryFilter() : void {
         var item:Object = null;
         var currentSelection:String = null;
         var k:* = 0;
         var modelAdded:Array = new Array();
         var inventoryCB:Array = new Array(
            {
               "label":this.uiApi.getText("ui.common.allTypes"),
               "type":""
            });
         var nb:int = this._inventoryList.length;
         var i:int = 0;
         while(i < nb)
         {
            item = this._inventoryList[i];
            if(modelAdded.indexOf(item.name) == -1)
            {
               modelAdded.push(item.name);
               inventoryCB.push(
                  {
                     "label":item.name,
                     "type":item.name
                  });
            }
            i++;
         }
         if(this.cb_inventory.value)
         {
            currentSelection = this.cb_inventory.value.label;
            nb = inventoryCB.length;
            k = 0;
            while(k < nb)
            {
               if(inventoryCB[k].label == currentSelection)
               {
                  this.cb_inventory.dataProvider = inventoryCB;
                  this.cb_inventory.selectedIndex = k;
                  break;
               }
               k++;
            }
         }
         else
         {
            this.cb_inventory.dataProvider = inventoryCB;
         }
      }
      
      private function updateInventory(filterType:String) : void {
         var item:Object = null;
         var textFilter:String = this.lbl_searchInventory.text;
         var gridProvider:Array = new Array();
         if((this._inventoryList.length == 0) && (_currentSource == SOURCE_INVENTORY))
         {
            this.sourceSelected(-1);
         }
         var nbMount:int = 0;
         var nb:int = this._inventoryList.length;
         var i:int = 0;
         while(i < nb)
         {
            item = this._inventoryList[i];
            if((filterType == "") || (item.name == filterType))
            {
               if((textFilter == "") || (!(item.name.toLowerCase().indexOf(textFilter.toLowerCase()) == -1)))
               {
                  gridProvider.push(item);
                  nbMount++;
               }
            }
            i++;
         }
         this.gd_inventory.dataProvider = gridProvider;
         this.lbl_certificates.text = this.uiApi.getText("ui.mount.numCertificates",nbMount);
      }
      
      private function mountFilter(mount:Object, filter:int, filter2:int, filter3:int, textFilter:String) : Boolean {
         if(!this.mountFilteredBy(mount,filter))
         {
            return false;
         }
         if(!this.mountFilteredBy(mount,filter2))
         {
            return false;
         }
         if(!this.mountFilteredBy(mount,filter3))
         {
            return false;
         }
         if(textFilter)
         {
            return !(mount.name.toLowerCase().indexOf(textFilter.toLowerCase()) == -1);
         }
         return true;
      }
      
      private function mountFilteredBy(mount:Object, filter:int) : Boolean {
         var nCapacity:* = 0;
         var i:* = 0;
         switch(filter)
         {
            case MountFilterEnum.MOUNT_ALL:
               return true;
            case MountFilterEnum.MOUNT_MALE:
               return !mount.sex;
            case MountFilterEnum.MOUNT_FEMALE:
               return mount.sex;
            case MountFilterEnum.MOUNT_FRUITFUL:
               return mount.isFecondationReady;
            case MountFilterEnum.MOUNT_NOFRUITFUL:
               return (!mount.isFecondationReady) && (!(mount.reproductionCount == -1)) && (!(mount.reproductionCount == 20)) && (mount.level >= 5);
            case MountFilterEnum.MOUNT_FERTILIZED:
               return mount.fecondationTime > 0;
            case MountFilterEnum.MOUNT_BABY:
               return mount.borning;
            case MountFilterEnum.MOUNT_MOUNTABLE:
               return mount.isRideable;
            case MountFilterEnum.MOUNT_NAMELESS:
               return mount.name == this._nameless;
            case MountFilterEnum.MOUNT_SPECIAL:
               return mount.ability.length;
            case MountFilterEnum.MOUNT_TRAINABLE:
               return (mount.maturityForAdult) && (mount.level < 5);
            case MountFilterEnum.MOUNT_100_TIRED:
               return mount.boostLimiter == mount.boostMax;
            case MountFilterEnum.MOUNT_MORE50_TIRED:
               return (mount.boostLimiter >= mount.boostMax / 2) && (!(mount.boostLimiter == mount.boostMax));
            case MountFilterEnum.MOUNT_LESS50_TIRED:
               return (mount.boostLimiter < mount.boostMax / 2) && (!(mount.boostLimiter == 0));
            case MountFilterEnum.MOUNT_NOTIRED:
               return mount.boostLimiter == 0;
            case MountFilterEnum.MOUNT_STERILIZED:
               return (mount.reproductionCount == -1) || (mount.reproductionCount == 20);
            case MountFilterEnum.MOUNT_POSITIVE_SERENITY:
               return mount.serenity >= 0;
            case MountFilterEnum.MOUNT_NEGATIVE_SERENITY:
               return mount.serenity < 0;
            case MountFilterEnum.MOUNT_AVERAGE_SERENITY:
               return (mount.serenity > -2000) && (mount.serenity < 2000);
            case MountFilterEnum.MOUNT_NEED_LOVE:
               return mount.love < 7500;
            case MountFilterEnum.MOUNT_FULL_LOVE:
               return mount.love >= 7500;
            case MountFilterEnum.MOUNT_NEED_STAMINA:
               return mount.stamina < 7500;
            case MountFilterEnum.MOUNT_FULL_STAMINA:
               return mount.stamina >= 7500;
            case MountFilterEnum.MOUNT_IMMATURE:
               return mount.maturity < mount.maturityForAdult;
            case MountFilterEnum.MOUNT_OWNER:
               return mount.ownerId == this.playerApi.id();
            case MountFilterEnum.MOUNT_NEED_ENERGY:
               return (mount.isRideable) && (mount.energy < mount.energyMax);
            case MountFilterEnum.MOUNT_FULL_ENERGY:
               return (mount.isRideable) && (mount.energy >= mount.energyMax);
            default:
               if(filter < 0)
               {
                  return mount.model == -filter;
               }
               if(filter > 100)
               {
                  nCapacity = mount.ability.length;
                  if(nCapacity)
                  {
                     i = 0;
                     while(i < nCapacity)
                     {
                        if(mount.ability[i].id == filter - 100)
                        {
                           return true;
                        }
                        i++;
                     }
                  }
               }
               return false;
         }
      }
      
      private function searchSource(mountId:int) : uint {
         var paddockMount:Object = null;
         var barnMount:Object = null;
         if((this.playerApi.getMount()) && (this.playerApi.getMount().id == mountId))
         {
            return SOURCE_EQUIP;
         }
         for each(paddockMount in this.gd_paddock.dataProvider)
         {
            if(paddockMount.id == mountId)
            {
               return SOURCE_PADDOCK;
            }
         }
         for each(barnMount in this.gd_barn.dataProvider)
         {
            if(barnMount.id == mountId)
            {
               return SOURCE_BARN;
            }
         }
         return SOURCE_INVENTORY;
      }
      
      private function moveMount(source:int, target:int) : void {
         switch(target)
         {
            case SOURCE_PADDOCK:
               switch(source)
               {
                  case SOURCE_EQUIP:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_EQUIPED_MOUNTPADDOCK_PUT,this._mount.id));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_INVENTORY:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_UNCERTIF_TO_PADDOCK,this.gd_inventory.selectedItem.objectUID));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_BARN:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_PUT,this._mount.id));
                     this.sourceSelected(-1);
                     break;
               }
               break;
            case SOURCE_BARN:
               switch(source)
               {
                  case SOURCE_PADDOCK:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_GET,this._mount.id));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_EQUIP:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_PUT,this._mount.id));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_INVENTORY:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_UNCERTIF,this.gd_inventory.selectedItem.objectUID));
                     this.sourceSelected(-1);
                     break;
               }
               break;
            case SOURCE_INVENTORY:
               switch(source)
               {
                  case SOURCE_PADDOCK:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_CERTIF,this._mount.id));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_BARN:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_CERTIF,this._mount.id));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_EQUIP:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_EQUIPED_CERTIF,this._mount.id));
                     this.sourceSelected(-1);
                     break;
               }
               break;
            case SOURCE_EQUIP:
               switch(source)
               {
                  case SOURCE_PADDOCK:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_EQUIPED_MOUNTPADDOCK_GET,this._mount.id));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_BARN:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_GET,this._mount.id));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_INVENTORY:
                     this.sysApi.sendAction(new ExchangeHandleMountStable(ExchangeHandleMountStableTypeEnum.EXCHANGE_UNCERTIF_TO_EQUIPED,this.gd_inventory.selectedItem.objectUID));
                     this.sourceSelected(-1);
                     break;
               }
               break;
         }
      }
      
      private function showMoreFilter(visible:Boolean, target:String) : void {
         if(visible)
         {
            if(!this.cb_barn2.visible)
            {
               this.cb_barn2.visible = true;
               this.ctr_barn.y = 155;
               this.gd_barn.height = 290;
               this.tx_barnTexture.height = 350;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.btn_addFilter.visible = true;
               this.btn_removeFilter2.visible = true;
               this.btn_removeFilter1.visible = true;
            }
            else if(!this.cb_barn3.visible)
            {
               this.cb_barn3.visible = true;
               this.ctr_barn.y = 185;
               this.gd_barn.height = 260;
               this.tx_barnTexture.height = 320;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.btn_addFilter.visible = false;
               this.btn_removeFilter3.visible = true;
               this.btn_removeFilter1.visible = true;
            }
            
         }
         else if(target == "btn_removeFilter1")
         {
            if((this.cb_barn3.visible) && (this.cb_barn2.visible))
            {
               this.cb_barn.selectedIndex = this.cb_barn2.selectedIndex;
               this.cb_barn2.selectedIndex = this.cb_barn3.selectedIndex;
               this.cb_barn3.visible = false;
               this.cb_barn3.selectedIndex = 0;
               this.ctr_barn.y = 155;
               this.gd_barn.height = 290;
               this.tx_barnTexture.height = 350;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.btn_addFilter.visible = true;
               this.btn_removeFilter3.visible = false;
            }
            else if(this.cb_barn2.visible)
            {
               this.cb_barn2.visible = false;
               this.cb_barn.selectedIndex = this.cb_barn2.selectedIndex;
               this.cb_barn2.selectedIndex = 0;
               this.ctr_barn.y = 125;
               this.gd_barn.height = 320;
               this.tx_barnTexture.height = 380;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.btn_addFilter.visible = true;
               this.btn_removeFilter2.visible = false;
               this.btn_removeFilter1.visible = false;
            }
            
         }
         else if(target == "btn_removeFilter2")
         {
            if(this.cb_barn3.visible)
            {
               this.cb_barn2.selectedIndex = this.cb_barn3.selectedIndex;
               this.cb_barn3.visible = false;
               this.cb_barn3.selectedIndex = 0;
               this.ctr_barn.y = 155;
               this.gd_barn.height = 290;
               this.tx_barnTexture.height = 350;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.btn_addFilter.visible = true;
               this.btn_removeFilter3.visible = false;
            }
            else
            {
               this.cb_barn2.visible = false;
               this.cb_barn2.selectedIndex = 0;
               this.ctr_barn.y = 125;
               this.gd_barn.height = 320;
               this.tx_barnTexture.height = 380;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.btn_addFilter.visible = true;
               this.btn_removeFilter2.visible = false;
               this.btn_removeFilter1.visible = false;
            }
         }
         else if(target == "btn_removeFilter3")
         {
            this.cb_barn3.visible = false;
            this.cb_barn3.selectedIndex = 0;
            this.ctr_barn.y = 155;
            this.gd_barn.height = 290;
            this.tx_barnTexture.height = 350;
            this.gd_barn.dataProvider = this.gd_barn.dataProvider;
            this.btn_addFilter.visible = true;
            this.btn_removeFilter3.visible = false;
         }
         
         
         
      }
      
      private function onCertificateMountData(mountInfo:Object) : void {
         var source:int = this.searchSource(mountInfo.id);
         this.showMountInfo(mountInfo,source);
         this.sourceSelected(source);
      }
      
      private function onMountStableUpdate(stableList:Object, paddockList:Object, inventoryList:Object) : void {
         var filterType:* = 0;
         var filterType2:* = 0;
         var filterType3:* = 0;
         var ele:MountData = null;
         var sFilterType:String = null;
         var source:* = 0;
         if(stableList)
         {
            this._barnList = new Array();
            for each(ele in stableList)
            {
               this._barnList.push(ele);
            }
            filterType = this.cb_barn.value.type;
            filterType2 = this.cb_barn2.value.type;
            filterType3 = this.cb_barn3.value.type;
            this.updateBarnFilter();
            this.updateBarn(filterType,filterType2,filterType3);
         }
         if(paddockList)
         {
            this._paddockList = new Array();
            for each(ele in paddockList)
            {
               this._paddockList.push(ele);
            }
            filterType = this.cb_paddock.value.type;
            this.updatePaddockFilter();
            this.updatePaddock(filterType);
         }
         if(inventoryList)
         {
            this._inventoryList = inventoryList;
            sFilterType = this.cb_inventory.value.type;
            this.updateInventoryFilter();
            this.updateInventory(sFilterType);
         }
         if(this._mount)
         {
            source = this.searchSource(this._mount.id);
            if(source == SOURCE_PADDOCK)
            {
               this.gd_paddock.selectedItem = this._mount;
            }
            else if(source == SOURCE_BARN)
            {
               this.gd_barn.selectedItem = this._mount;
            }
            
            this.showMountInfo(this._mount,source);
         }
      }
      
      public function onUiLoaded(name:String) : void {
         if(name == UIEnum.MOUNT_INFO)
         {
            this._mountInfoUiLoaded = true;
            this.sysApi.removeHook(UiLoaded);
            this._mountInfoUi = this.uiApi.getUi(UIEnum.MOUNT_INFO);
            this.showMountInfo(this._mount,_currentSource);
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.gd_barn)
         {
            if(this.gd_barn.selectedIndex != -1)
            {
               if(this.gd_paddock.selectedIndex != -1)
               {
                  this.gd_paddock.selectedIndex = -1;
               }
               if(this.gd_inventory.selectedIndex != -1)
               {
                  this.gd_inventory.selectedIndex = -1;
               }
               if(selectMethod == 1)
               {
                  this.sysApi.sendAction(new ExchangeHandleMountStable(6,this.gd_barn.selectedItem.id));
               }
               else if(this.gd_barn.selectedItem)
               {
                  this.showMountInfo(this.gd_barn.selectedItem,2);
                  this.sourceSelected(2);
               }
               else
               {
                  this.sourceSelected(-1);
               }
               
            }
         }
         else if(target == this.gd_paddock)
         {
            if(this.gd_paddock.selectedIndex != -1)
            {
               if(this.gd_barn.selectedIndex != -1)
               {
                  this.gd_barn.selectedIndex = -1;
               }
               if(this.gd_inventory.selectedIndex != -1)
               {
                  this.gd_inventory.selectedIndex = -1;
               }
               if(selectMethod == 1)
               {
                  this.sysApi.sendAction(new ExchangeHandleMountStable(7,this.gd_paddock.selectedItem.id));
               }
               else if(this.gd_paddock.selectedItem)
               {
                  this.showMountInfo(this.gd_paddock.selectedItem,3);
                  this.sourceSelected(3);
               }
               else
               {
                  this.sourceSelected(-1);
               }
               
            }
         }
         else if(target == this.gd_inventory)
         {
            if(this.gd_inventory.selectedIndex != -1)
            {
               if(this.gd_barn.selectedIndex != -1)
               {
                  this.gd_barn.selectedIndex = -1;
               }
               if(this.gd_paddock.selectedIndex != -1)
               {
                  this.gd_paddock.selectedIndex = -1;
               }
               if(selectMethod == 1)
               {
                  this.sysApi.sendAction(new ExchangeHandleMountStable(5,this.gd_inventory.selectedItem.objectUID));
                  this.gd_inventory.selectedIndex = this.gd_inventory.getIndex() - 1;
               }
               else if(this.mountApi.isCertificateValid(this.gd_inventory.selectedItem))
               {
                  this.sysApi.sendAction(new MountInfoRequest(this.gd_inventory.selectedItem));
               }
               else if(selectMethod != SelectMethodEnum.AUTO)
               {
                  this.sourceSelected(-1);
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.mount.invalidCertificate"),[this.uiApi.getText("ui.common.ok")]);
               }
               
               
            }
         }
         else if((target == this.cb_barn) && (isNewSelection))
         {
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if((target == this.cb_barn2) && (isNewSelection))
         {
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if((target == this.cb_barn3) && (isNewSelection))
         {
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if(target == this.cb_paddock)
         {
            this.updatePaddock(target.value.type);
         }
         else if(target == this.cb_inventory)
         {
            this.updateInventory(target.value.type);
         }
         
         
         
         
         
         
         
      }
      
      public function onRollOver(target:Object) : void {
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.ctr_mountEquiped)
         {
            this.showCurrentMountInfo();
         }
         else if(target == this.btn_stock)
         {
            this.moveMount(_currentSource,SOURCE_BARN);
         }
         else if(target == this.btn_park)
         {
            this.moveMount(_currentSource,SOURCE_PADDOCK);
         }
         else if(target == this.btn_equip)
         {
            this.moveMount(_currentSource,SOURCE_EQUIP);
         }
         else if(target == this.btn_exchange)
         {
            this.moveMount(_currentSource,SOURCE_INVENTORY);
         }
         else if(target == this.btn_close)
         {
            this.hideUi();
         }
         else if(target == this.btn_searchBarn)
         {
            if(this.ctr_searchBarn.visible)
            {
               this.ctr_searchBarn.visible = false;
               this.cb_barn.visible = true;
               this.lbl_searchBarn.text = "";
            }
            else
            {
               this.ctr_searchBarn.visible = true;
               this.cb_barn.visible = false;
               this.lbl_searchBarn.text = "";
               this.lbl_searchBarn.focus();
            }
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if(target == this.btn_searchPaddock)
         {
            if(this.ctr_searchPaddock.visible)
            {
               this.ctr_searchPaddock.visible = false;
               this.cb_paddock.visible = true;
               this.lbl_searchPaddock.text = "";
            }
            else
            {
               this.ctr_searchPaddock.visible = true;
               this.cb_paddock.visible = false;
               this.lbl_searchPaddock.text = "";
               this.lbl_searchPaddock.focus();
            }
            this.updatePaddock(this.cb_paddock.value.type);
         }
         else if(target == this.btn_searchInventory)
         {
            if(this.ctr_searchInventory.visible)
            {
               this.ctr_searchInventory.visible = false;
               this.cb_inventory.visible = true;
               this.lbl_searchInventory.text = "";
            }
            else
            {
               this.ctr_searchInventory.visible = true;
               this.cb_inventory.visible = false;
               this.lbl_searchInventory.text = "";
               this.lbl_searchInventory.focus();
            }
            this.updateInventory(this.cb_inventory.value.type);
         }
         else if(target == this.btn_barnType)
         {
            switchSort(this._barnSortOrder,SORT_TYPE_TYPE);
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if(target == this.btn_barnGender)
         {
            switchSort(this._barnSortOrder,SORT_TYPE_GENDER);
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if(target == this.btn_barnName)
         {
            switchSort(this._barnSortOrder,SORT_TYPE_NAME);
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if(target == this.btn_barnLevel)
         {
            switchSort(this._barnSortOrder,SORT_TYPE_LEVEL);
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if(target == this.btn_paddockType)
         {
            switchSort(this._paddockSortOrder,SORT_TYPE_TYPE);
            this.updatePaddock(this.cb_paddock.value.type);
         }
         else if(target == this.btn_paddockGender)
         {
            switchSort(this._paddockSortOrder,SORT_TYPE_GENDER);
            this.updatePaddock(this.cb_paddock.value.type);
         }
         else if(target == this.btn_paddockName)
         {
            switchSort(this._paddockSortOrder,SORT_TYPE_NAME);
            this.updatePaddock(this.cb_paddock.value.type);
         }
         else if(target == this.btn_paddockLevel)
         {
            switchSort(this._paddockSortOrder,SORT_TYPE_LEVEL);
            this.updatePaddock(this.cb_paddock.value.type);
         }
         else if(target == this.btn_addFilter)
         {
            this.showMoreFilter(true,target.name);
         }
         else if((target == this.btn_removeFilter1) || (target == this.btn_removeFilter2) || (target == this.btn_removeFilter3))
         {
            this.showMoreFilter(false,target.name);
         }
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if(this.lbl_searchBarn.haveFocus)
         {
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if(this.lbl_searchPaddock.haveFocus)
         {
            this.updatePaddock(this.cb_paddock.value.type);
         }
         else if(this.lbl_searchInventory.haveFocus)
         {
            this.updateInventory(this.cb_inventory.value.type);
         }
         
         
      }
      
      public function updateFilterLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.lbl_filterName.text = data.label;
            switch(data.filterGroup)
            {
               case 5:
                  componentsRef.lbl_filterName.cssClass = "bonta";
                  break;
               case 6:
                  componentsRef.lbl_filterName.cssClass = "bonus";
                  break;
               default:
                  componentsRef.lbl_filterName.cssClass = "p";
            }
         }
      }
      
      private function onShortCut(s:String) : Boolean {
         if(!this.mainCtr.visible)
         {
            return false;
         }
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
               this.hideUi();
               return true;
            case SHORTCUT_STOCK:
               this.moveMount(_currentSource,SOURCE_BARN);
               return true;
            case SHORTCUT_PARK:
               this.moveMount(_currentSource,SOURCE_PADDOCK);
               return true;
            case SHORTCUT_EQUIP:
               this.moveMount(_currentSource,SOURCE_EQUIP);
               return true;
            case SHORTCUT_EXCHANGE:
               this.moveMount(_currentSource,SOURCE_INVENTORY);
               return true;
            default:
               return false;
         }
      }
      
      private function onMountRenamed(mountId:int, mountName:String) : void {
         if((this.playerApi.getMount()) && (this.playerApi.getMount().id == mountId))
         {
            this.showPlayerMountInfo();
         }
      }
      
      private function onMountReleased(mountId:Number) : void {
         if((this._mount) && (this._mount.id == mountId))
         {
            this.sourceSelected(-1);
         }
      }
      
      private function applySort(list:Array, sortOptions:Array) : void {
         this._lastSortOptions = sortOptions;
         list.sort(this.sortFunction);
      }
      
      public function sortFunction(a:Object, b:Object) : int {
         var se:Object = null;
         for each(se in this._lastSortOptions)
         {
            switch(se.type)
            {
               case SORT_TYPE_TYPE:
                  if(a.description < b.description)
                  {
                     return se.asc?-1:1;
                  }
                  if(a.description > b.description)
                  {
                     return se.asc?1:-1;
                  }
                  continue;
               case SORT_TYPE_GENDER:
                  if(a.sex < b.sex)
                  {
                     return se.asc?-1:1;
                  }
                  if(a.sex > b.sex)
                  {
                     return se.asc?1:-1;
                  }
                  continue;
               case SORT_TYPE_NAME:
                  if(a.name < b.name)
                  {
                     return se.asc?-1:1;
                  }
                  if(a.name > b.name)
                  {
                     return se.asc?1:-1;
                  }
                  continue;
               case SORT_TYPE_LEVEL:
                  if(a.level < b.level)
                  {
                     return se.asc?-1:1;
                  }
                  if(a.level > b.level)
                  {
                     return se.asc?1:-1;
                  }
                  continue;
               default:
                  continue;
            }
         }
         return 0;
      }
   }
}
