// Action script...

// [Initial MovieClip Action of sprite 832]
#initclip 44
class ank.battlefield.datacenter.Sprite extends Object
{
    var id, clipClass, _sGfxFile, _nCellNum, _nDirection, _oSequencer, _bInMove, _bVisible, _bClear, _eoLinkedChilds, __get__linkedParent, __get__childIndex, _oLinkedParent, __get__gfxFile, __get__defaultAnimation, __get__startAnimation, _nStartAnimationTimer, __get__startAnimationTimer, __get__speedModerator, __get__isVisible, __get__isInMove, __get__isClear, __get__cellNum, __get__direction, _nColor1, __get__color1, _nColor2, __get__color2, _nColor3, __get__color3, _aAccessories, __get__accessories, __get__sequencer, __get__allDirections, __get__forceWalk, __get__forceRun, __set__accessories, __set__allDirections, __set__cellNum, __set__childIndex, __set__color1, __set__color2, __set__color3, __set__defaultAnimation, __set__direction, __set__forceRun, __set__forceWalk, __set__gfxFile, __get__hasChilds, __get__hasParent, __set__isClear, __set__isInMove, __set__isVisible, __get__linkedChilds, __set__linkedParent, __set__sequencer, __set__speedModerator, __set__startAnimation, __set__startAnimationTimer;
    function Sprite(nID, fClipClass, sGfxFile, nCellNum, nDir)
    {
        super();
        this.initialize(nID, fClipClass, sGfxFile, nCellNum, nDir);
    } // End of the function
    function initialize(nID, fClipClass, sGfxFile, nCellNum, nDir)
    {
        id = nID;
        clipClass = fClipClass;
        _sGfxFile = sGfxFile;
        _nCellNum = Number(nCellNum);
        _nDirection = nDir == undefined ? (1) : (Number(nDir));
        _oSequencer = new ank.utils.Sequencer(10000);
        _bInMove = false;
        _bVisible = true;
        _bClear = false;
        _eoLinkedChilds = new ank.utils.ExtendedObject();
    } // End of the function
    function get hasChilds()
    {
        return (_eoLinkedChilds.getLength() != 0);
    } // End of the function
    function get hasParent()
    {
        //return (this.linkedParent() != undefined);
    } // End of the function
    function get childIndex()
    {
        return (_nChildIndex);
    } // End of the function
    function set childIndex(nChildIndex)
    {
        _nChildIndex = nChildIndex;
        //return (this.childIndex());
        null;
    } // End of the function
    function get linkedChilds()
    {
        return (_eoLinkedChilds);
    } // End of the function
    function get linkedParent()
    {
        return (_oLinkedParent);
    } // End of the function
    function set linkedParent(oLinkedParent)
    {
        _oLinkedParent = oLinkedParent;
        //return (this.linkedParent());
        null;
    } // End of the function
    function get gfxFile()
    {
        return (_sGfxFile);
    } // End of the function
    function set gfxFile(sGfxFile)
    {
        _sGfxFile = sGfxFile;
        //return (this.gfxFile());
        null;
    } // End of the function
    function get defaultAnimation()
    {
        return (_sDefaultAnimation);
    } // End of the function
    function set defaultAnimation(value)
    {
        _sDefaultAnimation = value;
        //return (this.defaultAnimation());
        null;
    } // End of the function
    function get startAnimation()
    {
        return (_sStartAnimation);
    } // End of the function
    function set startAnimation(value)
    {
        _sStartAnimation = value;
        //return (this.startAnimation());
        null;
    } // End of the function
    function get startAnimationTimer()
    {
        return (_nStartAnimationTimer);
    } // End of the function
    function set startAnimationTimer(value)
    {
        _nStartAnimationTimer = value;
        //return (this.startAnimationTimer());
        null;
    } // End of the function
    function get speedModerator()
    {
        return (_nSpeedModerator);
    } // End of the function
    function set speedModerator(value)
    {
        _nSpeedModerator = Number(value);
        //return (this.speedModerator());
        null;
    } // End of the function
    function get isVisible()
    {
        return (_bVisible);
    } // End of the function
    function set isVisible(value)
    {
        _bVisible = value;
        //return (this.isVisible());
        null;
    } // End of the function
    function get isInMove()
    {
        return (_bInMove);
    } // End of the function
    function set isInMove(value)
    {
        _bInMove = value;
        //return (this.isInMove());
        null;
    } // End of the function
    function get isClear()
    {
        return (_bClear);
    } // End of the function
    function set isClear(value)
    {
        _bClear = value;
        //return (this.isClear());
        null;
    } // End of the function
    function get cellNum()
    {
        return (_nCellNum);
    } // End of the function
    function set cellNum(value)
    {
        _nCellNum = Number(value);
        //return (this.cellNum());
        null;
    } // End of the function
    function get direction()
    {
        return (_nDirection);
    } // End of the function
    function set direction(value)
    {
        _nDirection = Number(value);
        //return (this.direction());
        null;
    } // End of the function
    function get color1()
    {
        return (_nColor1);
    } // End of the function
    function set color1(value)
    {
        _nColor1 = Number(value);
        //return (this.color1());
        null;
    } // End of the function
    function get color2()
    {
        return (_nColor2);
    } // End of the function
    function set color2(value)
    {
        _nColor2 = Number(value);
        //return (this.color2());
        null;
    } // End of the function
    function get color3()
    {
        return (_nColor3);
    } // End of the function
    function set color3(value)
    {
        _nColor3 = Number(value);
        //return (this.color3());
        null;
    } // End of the function
    function get accessories()
    {
        return (_aAccessories);
    } // End of the function
    function set accessories(value)
    {
        _aAccessories = value;
        //return (this.accessories());
        null;
    } // End of the function
    function get sequencer()
    {
        return (_oSequencer);
    } // End of the function
    function set sequencer(value)
    {
        _oSequencer = value;
        //return (this.sequencer());
        null;
    } // End of the function
    function get allDirections()
    {
        return (_bAllDirections);
    } // End of the function
    function set allDirections(bAllDirections)
    {
        _bAllDirections = bAllDirections;
        //return (this.allDirections());
        null;
    } // End of the function
    function get forceWalk()
    {
        return (_bForceWalk);
    } // End of the function
    function set forceWalk(bForceWalk)
    {
        _bForceWalk = bForceWalk;
        //return (this.forceWalk());
        null;
    } // End of the function
    function get forceRun()
    {
        return (_bForceRun);
    } // End of the function
    function set forceRun(bForceRun)
    {
        _bForceRun = bForceRun;
        //return (this.forceRun());
        null;
    } // End of the function
    var bAnimLoop = false;
    var _nChildIndex = -1;
    var _sDefaultAnimation = "static";
    var _sStartAnimation = "static";
    var _nSpeedModerator = 1;
    var _bAllDirections = true;
    var _bForceWalk = false;
    var _bForceRun = false;
} // End of Class
#endinitclip
