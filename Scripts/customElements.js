// JavaScript Document
/*
 * Custom Script Functions for Layout Interactive Elements
 * Developed : SepiaSolutions
 * Updated: Oct 2014
 * Client : Alpine Vessel and Client Management
 * Version : 1.5v
*/

jQuery( document ).ready( function ($) {


	

//----------------------------------------
//    Select Elements -singular 
//----------------------------------------
// console.clear()
// console.time("select");
var	targetElement = 'select';
$(window).load(function() {

	if ($('.smart-phone').is(":hidden")) {
		prettyInput( $(targetElement) );
	} 
// console.timeEnd('select');
})



function prettyInput( element ) {


	// fancy select style application 
	$(element).each( function (i) {
		
		elem  = $(this);
		elem.addClass('select-customized');

		// nChild = $('option', elem ).length > 5 ? filterShow = "" : filterShow = "no-filter";

		if( elem.is("[multiple]") ) {
			
			_contClass = "select-box multiple ";
			multiSelect = true ;

		} else {
			
			_contClass = "select-box single"  ;
			multiSelect = false ;

		}
	

		
		// main interface which is visible by default
		var mainInterface = ""; 
		
		mainInterface  = '<div class="bg-overlay"></div>';
		mainInterface += '<div class="' + _contClass + '">';
		mainInterface += '<div class="select-item">';
		// mainInterface += '	<label class="selected-option">Please Select</label>';
		mainInterface += '	<span class="select-arrow"></span>';
		
		mainInterface += '<div class="select-cont id-'+ i + '">';
		mainInterface += '  <div class="filter"><input class="finder" type="text" /><a href="#" class="btn-find">Search</a></div>';
		mainInterface += '</div>';
	   	
	   	mainInterface += '	</div>';
	   	mainInterface += '</div>';
	   	

	   		   
	    $(mainInterface).insertAfter(elem);
	    elem.appendTo(elem.parent().find($('.select-cont.id-' + i)));
	    
		var elemParent = $(this).parent($('div'));
	     	
		redrawOption(this, elemParent,true);
	  
	}) // main select loop

}

	//----------------------------------
	// ADD CLICK TO SINGLE SELECT
	//------------------------------------
/*
	$('.select-box.single').on( 'click','li.act-option',  function (e) {
		
		$('.select-box.single li.selected').removeClass('selected').addClass('act-option');
		
		$(this).addClass('selected').removeClass('act-option');

		$(this).parents('.select-box').find('label.selected-option').html( $(this).html() );

		var selVal = $(this).attr('data-value')
		$(this).parents('.select-box').find('select:first').val( selVal ).trigger('change');

//		 console.log(selVal);

		// hide container
		hideBox('.select-box .option-box');


	})


	//----------------------------------------
	// Multile select with click or Drag!
	//----------------------------------------
		
		// CLICK------------------------------
		var dragMode = false;
		$('.select-box.multiple').on( 'click', 'li.act-option', function(e){

			//$(this).addClass('selected');

		})


		//drag   // MOUSE DOWN ------------------------------
		$('.select-box.multiple').on( 'mousedown', 'li' , function(e){
			e.preventDefault();
			dragMode = true;
			
			//$(this).toggleClass('.act-option selected');
			$(this).addClass('selected').removeClass('act-option')


		});

		// MOUSE MOVE ------------------------------
		$('.select-box.multiple').on( 'mousemove', 'li.act-option', function(e){
			if( dragMode ) {
				
				$(this).addClass('selected').removeClass('act-option');

				e.preventDefault();
				////  console.log('mouse move');
			}
		});


		// MOUSE UP ------------------------------
		$('.select-box.multiple').on('mouseup','li',function(e) {
			
//			 console.log("mouse up");
			dragMode = false;
			var parent  =$(this).parents('.select-box');
			var select = parent.find('select:first');
			
			// reset
			select.val("").removeAttr('selected');
			var selectedItemTag="";			
			valset=[];

			$( 'li.selected', parent ).each(function(i){
				
				multiInd = $(this).attr('data-index');
				valset[i] = $(this).attr('data-value');

				var _dataIndex = $(this).attr('data-index');
				var _text = $(this).text();
				selectedItemTag += "<div class='sel-item-tag' data-index="+ _dataIndex +" title='" + _text +"'><span>" + _text +"</span><span class='del-item'></span></div>";

				
				
			});
			
			// console.log(valset);
			select.val(valset);
			
			defaultTextHolder = parent.find($('.selected-option'))
			//// console.log(defaultTextHolder, " " , selectedItemTag)
			
			// append tags to selection 
			$(defaultTextHolder).html(selectedItemTag);


			
			// hide container
			if(! e.ctrlKey ) {
				hideBox('.select-box .option-box');
			}

		});


		// MOUSE LEAVE ------------------------------
		$('.select-box.multiple ul').on('mouseleave', function(e) {
			dragMode = false;
		});

	*/

/* ----------------------------- */

 




// show hide menu.
$('.content-block,#mydialog').on('click','.selected-option', function () {
	$(this).next().trigger('click');
})


// ---------------------------------------------------------------------------
// EVENTS CLICK --------------------------------------------------------------
// ---------------------------------------------------------------------------

$('.content-block, #mydialog').on('click','.select-arrow', function () {
	console.log('arrow target clicked');
	//target cached!
	var parent = $(this).parents('.select-box');
	var target = parent.find('.select-cont');


	// background overlay layer
	var bg = $(this).parents('.select-box').prev('.bg-overlay');


	if( target.is(":hidden") ) {
		
		$('.bg-overlay').hide();
		$('.select-cont').hide();
		$('.select-box').removeClass('active');
		
		// show overlay
		bg.show()



		// fix width of selector
		var sWidth = parent.outerWidth() + 14;
		$('select', target).css('width', sWidth);

		target.show();
		$('.select-arrow').removeClass('close')
		parent.addClass('active');
		$(this).addClass('close');

		parent.find('.finder').focus();


	} else {
		parent.removeClass('active')
		target.hide();
		target.find('option').removeClass('not-found');
		$(this).removeClass('close');
		$('.bg-overlay').hide();
	}
	
	
})



$('.content-block').on('click','.filter .btn-find', function (key) {
	
	// var type;
	// clearTimeout(type);
	console.log("finder clicked");
	textbox = $(this).prev('input')
	val = textbox.val()
	
	searchList( val, textbox);
	//return false;

	// type = setTimeout(
	// 	function() {
	// 		// console.log(val);
	// 	}, 1000 );


	
})





//---------------------------------
// Single Selector
//---------------------------------
$('.content-block,#mydialog').on('click','.select-box.single .select-customized option', function () {
	var parent = $(this).parents('.select-box')
	// console.log('options clicked');
	parent.find('label.selected-option').html( $(this).html() );
	$('.select-cont',parent).hide();
	parent.removeClass('active');

	// class work
	$(this).siblings().removeClass('selected');
	$(this).addClass("selected");

})


//-------------------------------------------------------------
// Multi Selector
//-------------------------------------------------------------

/* Mouse down Event */

var dragMode = false

// ------------------------------
// Selected colr blink fix 
// ------------------------------
var tmpColor = $('option:checked').css('background-color');

//$('option:checked').css({ 'background-color':tmpColor , 'color':'white' });

$('.content-block, #mydialog').on('mousedown','.select-box.multiple .select-customized option', function () {
	// turn on drag mode
	dragMode = true

	$(this).addClass('selected');
	$(this).parents('.select-item').find('.selected-option').remove()

	// adding tags
	var allLabels = $(this).parents('.select-item').children('.sel-item-tag ');

	
})


// mouse drag 
$('.content-block, #mydialog').on('mouseover','.select-box.multiple .select-customized option', function () {
	
	if(dragMode) {
		
		$(this).addClass('selected');
	}

})


/* Mouse Up Event */

$('.content-block,#mydialog').on('mouseup','.select-box.multiple .select-customized option', function () {
	

	// adding tags
	var allLabels = $(this).parents('.select-item').children('.sel-item-tag ');
	
	var _tmpValue =[];
	
	var newTag = "";

	console.log(newTag)
	
	$(this).parents('.select-item').find(".selected-option").remove();
	$(this).parents('.select-item').find(".sel-item-tag").remove();
	
	$(this).parents('.select-box').find('.selected').each(function (i) {
		
		_text = $(this).text();
		_value = $(this).val();

		newTag += "<label class='sel-item-tag' data-value=" + _value + " title='" + _text +"'><span>" + _text +"</span><span class='del-item'></span></label>";
		_tmpValue[i] = $(this).val();
	})

	$(newTag).appendTo($(this).parents('.select-item'));
	$(this).parent().val(_tmpValue);

	dragMode = false;
	
	console.log(newTag)

	return false

})



$('.content-block,#mydialog').on('click','.select-box .selected',function (e) {
	
	return false
})


// tag cleaner
$('.content-block,#mydialog').on('click','.select-box .del-item',function(e) {
	
	var parent = $(this).parents('.select-item');
	selector = parent.find('select')
	delArray = $(this).parent().attr('data-value');

	// set temp array from selector menu
	selectVal = selector.val()
	
	toDel = selectVal.indexOf(delArray);
	
	// delete value from Multi selector Array value
	if ( toDel != -1 || toDel != null ) {
		
		// remove selected item from Array
		selectVal.splice(toDel,1);
		
		// apply new array to selector value
		selector.val(selectVal);
		$(this).parent().remove();
		

		// remove class of selected
		selector.children('option[value="'+ delArray +'"]').removeClass('selected');

		//  triger change for option
		selector.children('option[value="'+ delArray +'"]').trigger('change');

	}


})




//-----------------------------------------------------
// AJAX Request Complete , Redraw All selects
//-----------------------------------------------------
$(document).ajaxComplete(function() {

	setTimeout(function () {

		$(targetElement).each(function() {
			
			var elemParent = $(this).parent($('div'));
			var masterParent = $(this).parents('.select-item')
			$('label.selected-option', masterParent ).remove();

			
			redrawOption( $(this), elemParent , false );

		})


		$('label.selected-option').each(function () {
			if($(this).parent().find('label').length > 1 ) {
				$(this).remove()
			}
		})

	}, 100 )

})




//------------------------------------------------------
// search filter 
//-----------------------------------------------------

function searchList( inputVal, textbox ) {
    /*
    UL list container where search gonna be performed
    */

    // jQuery Method, slower for large list
    // var item = $(textbox).parent().next()
    // var itemList = item.find('option');

    // var result = item.find('.note-list');

    // $('option', item).not(':Contains('+ inputVal +')').hide().addClass('not-found');
    var selectItem  = $(textbox).parent().next().attr('id')  ;

    // get item by name or ID, if ID is not available go for name
    if ( selectItem == null || selectItem == "" || selecItem =="undefined") {
    	selectItem = $(textbox).parent().next().attr('name');
    	listItem = document.getElementByName(selectItem).children;
    } else {

    	listItem = document.getElementById(selectItem).children;
    }




    listLength = listItem.length ;
    reg = new RegExp (inputVal ,'i');

    // for ( item in listItem ) {
    // 	mm = reg.test(listItem[item].innerHTML)
    // 	if( mm != true ) {
    // 		listItem[item].setAttribute('class','not-found');
    // 	}

    // }

   
	//console.time("for")
	 for ( i = 0; i < listLength; i++ ) {
	 	
	 	txtVal = reg.test(listItem[i].innerHTML)
	 	
	 	if( txtVal != true ) {
	 		//listItem[i].setAttribute('class','not-found');
	 		listItem[i].className = listItem[i].className + " not-found";
	 	}

	 }
	 return false
    
    //console.timeEnd('for')


    
    

} // searchList(inputVal, textbox )



    //------------------------
    // Bind Keys
    //------------------------
    $('.content-block, #mydialog').on('keyup','.filter input', function (key) {
    	
		var textbox = $(this);
		var itemList = $(this).parent().next('select');
		
		if ( $(textbox).val() == "") {
		    $(textbox).val("");
		    // $('label', result).html("");
		    $('option', itemList).removeClass('not-found');
		}

		else if (key.keyCode == 27  ) {
			hideBox( textbox.parents('.select-cont'));
		}


		if ( key.keyCode == 13 ) {
			textbox.next('.btn-find').trigger('click');
			//console.log("enter pressed")
		}

    
    });






// --------------------------------------------------------
// Redraw , added for ... when ajax is refereshed etc
	
	function redrawOption (element, elemParent, mode ) {
		 
		// mode to check its frist time or redrawing eleemnts = true : redraw

		var mode = mode || false;

		


		var masterParent = elemParent.parents('.select-box');
		
		var multiSelect = masterParent.hasClass("multiple") ? true : false;

		// console.log(masterParent)
		listSize = 	$('option' , element ).length;    
		

		// Reset Width of selector
		$(element).removeAttr('style');

		

		// Default label, "PLEASE SELECT"
		_attri_label = $(element).attr('data-label');
		_default_label = "Please Select";

		if( typeof _attri_label !== undefined || typeof _attri_label !== false )
		{
			_default_label = _attri_label;
		}


		// set the size of option List
		if ( listSize  <= 8 ) {
			
			$(element).attr('size', listSize).parent().addClass('no-filter');
			var sWidth = $(elemParent).width() + 19;
			$(element).css('width', sWidth)
		
		} else {
			
			$(element).attr('size',12).parent().removeClass('no-filter');

		} 


		var selectedItem = $('option:selected', element);


		
		// ADD SELECT OPTION title if nothing exist
		if ( (selectedItem.length < 1 /* && mode == true */ ) || $(element).val() == null ) {
			
			// Remove tags of selected item first / multi select.
			$('label.sel-item-tag', masterParent).remove();
			
			$('<label class="selected-option">' + _default_label + '</label>').insertBefore($('.select-arrow', masterParent));

		} else {

				$('label.sel-item-tag', masterParent).remove();
				
				// IF SEelct is multiple then apply tag style 
				if( multiSelect ) {
					
					var selectedItemTag = "";
					$(selectedItem).each( function (i) {
						
						//var _dataIndex = $(this).attr('data-index')
						var _text = $(this).text();
						var _dataValue = $(this).attr('value');

						selectedItemTag += "<label class='sel-item-tag' data-value=" + _dataValue + " title='" + _text +"'><span>" + _text +"</span><span class='del-item'></span></label>";

					})

					$(selectedItemTag).insertBefore($('.select-arrow', masterParent));

				} else {

					$('<label class="selected-option">' + _default_label + '</label>').insertBefore($('.select-arrow', masterParent));
					$(element).parents('.select-box').find('label.selected-option').html( selectedItem.html() );
				}

		} // master if/else


		// Add Class to Selected Item
		selectedItem.addClass('selected');
		//selectedItem.add(":visible:even").addClass('even')
		
		
	} // redraw ends -----------------





//-------------------------------------------
// Redraw selector 
// ------------------------------------------


function redraw (elementSelect) {
	
	 var elementTarget = $(elementSelect).parents().find('.select-box');
	 var elemParent = $(elementSelect).parent($('div'));
	 var childElements = $(elemParent).find('.opt-list').empty();

	 redrawOption(elementSelect, elemParent);

}

// ------------------------------------------


// repeated hider
function hideBox(element) {

	$(element).fadeOut(50, function() {
		
		$('option', element).removeClass('not-found')
		//$(this).find('ul li').removeClass('found').removeAttr('style');
		$('.note-list label').empty();
		$('input', element).val("");

		$(element).parent().prev('.bg-overlay').hide()

	})

	$('.select-arrow').removeClass('close');
}



// $(document).click(function(e) {
//     var target = e.target;

//     if (!$(target).is('.select-cont') && !$(target).parents().is('.select-cont')) {
//         hideBox(  $('.select-cont') )
//         $('.select-cont').removeClass('not-found');
//     }

// });


$('.content-block,#mydialog').on('click','.bg-overlay', function (){
	$(this).hide();
	hideBox($(this).next().find('.select-cont'));

})







 // custom animted show 
    jQuery.fn.showMe = function (speed,callback) {
        var durSpeed = speed || 250;
        
        $(this).css({
            'margin-top': -50,
            'opacity' : 0 
        }).show();

        $(this).animate({
            
            'margin-top' : 0,
            'opacity': 1

        }, {
            duration:durSpeed,
            queue:false
        })

    }


 //    $( document ).ajaxSuccess(function( event, request, settings ) {
	// 	prettyInput($('select'))
	// });






jQuery.expr[':'].Contains = function(a,i,m){
    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
};



}); //Jquery