// JavaScript Document
/*
 * Custom Script Functions for Layout Interactive Elements
 * Developed : SepiaSolutions
 * Updated: Mar 2014
 * Client : Alpine Vessel and Client Management
 */

$(document).ready(function() {
    console.clear();
    var welcome_msg  = "=============================================\n";
        welcome_msg += "\t   WELCOME DEVELOPER\n";
        welcome_msg += "=============================================\n";
    
    console.log(welcome_msg)

    globalEasing = "easeInQuad";

// t = $('td.head-0:first').width() + $('td.head-1:first').width() +$('td.head-2:first').width()


	
//----------------------------------------------------------------------
// SHOW TASKBAR 
// if IS MOBILE
//------------------------------------------------------------------------
    function resetMenuItem () {
       
        $('.smart-phone li, #taskBar, .desktop-menu, .lang-select').removeClass('active');
    }



    if( $('.smart-phone').is(":visible") ) {
        
        $('.task-menu').click(function () {
            
            

            if( $(this).hasClass('active') || $('#taskBar').hasClass('active') ) {
                resetMenuItem();
                $(this).removeClass('active');
                $('#taskBar').removeClass('active');
            
            } else {
            
               $(this).addClass('active');
                $('#taskBar').addClass('active');
            
            }

            return false;
        })
        

        $('.account').click(function () {
           
            resetMenuItem();

        })
        

        $('.lang').click(function () {
            resetMenuItem();
        })

    }


// SHOW TASKBAR ----------------------------------------------------------

//--------------------------------------------
// Generate Wizard Tabs
//--------------------------------------------
    if( $('.wizard').length ) {
       
    	console.time("Generate Form");
        
        generateTabs();
        
		console.timeEnd('Generate Form');
        // bind ajax complete
        
        
        //-----------------------------------------------------
        // AJAX Request Complete , Redraw All selects
        //-----------------------------------------------------
        $(document).ajaxComplete(function() {

            setTimeout(function () {
                generateTabs(), 50 
            });
                       
        })
    } // if else ends
    
	
	
	
	
	
//------------------------------------------------------------------------	
//------------------------------------------------------------------------
// WIZARD GENERATOR	
//------------------------------------------------------------------------
//------------------------------------------------------------------------	
	function checkActiveTab ( $item , $parent_item ) {
        // $item = tabs li.active
        
        // check if active tab is last or first
        // for first Tab
        if( $item.is(":first-child") ) {
            
            $('.btn.next').removeClass('disabled');
            $('.btn.prev').addClass('disabled');
        } 
        
        // for last tab
        else if( $item.is(":last-child") ) {
            
            $('.btn.next').addClass('disabled');
            $('.btn.prev').removeClass('disabled');
        }
        
        
        else {
            $('.btn.next, .btn.prev').removeClass('disabled');
        }


        //----------------------------------------
        // Added Tab validator. to check if tab's values are enough to proceed

        if( typeof $parent_item != "undefined" || typeof $parent_item == "object") {
        	checkField( $parent_item );
    	}

        
                        
    }
    
	

    
    

    
    
    
//------------------------------------------------------------------------	
//------------------------------------------------------------------------
// Field Validator
//------------------------------------------------------------------------
//------------------------------------------------------------------------	
   //------------------------------------------
   // Add Validation Class to All
   	function addValidator ($target) {
   		
   		$($target).each(function () {

   			if( $.trim($(this).val()) == "" ) {
   				$(this).addClass('is-empty');
   			}
   		})


   		// remove Class when button is pressed.
   		$('body').on('keyup', '.is-empty', function () {
   			$(this).removeClass('is-empty');
   		})

	}  
    



	//----------------------------------------------
    // Add Text Field Validator
    function checkValidator ($target) {
       
        $($target).blur( function () {

            if( $.trim($(this).val()) == "" ) {
                $(this).addClass('is-empty');
            
            } else {
                $(this).removeClass('is-empty');
            }

        })

    }
    
    
    
    //----------------------------------------------------
    // This is to check only Current Field set of Tab
    function checkField ( $target_tab ) {
        
        var total_count = $('input[type="text"]', $target_tab ).length;
        var empty_count = $('input.is-empty', $target_tab ).length;
        var target_ID  = $( $target_tab).attr('id');

        var target_tab  = $('.tabs li a[href="#' + target_ID + '"]').parent();

        
        // First Check Empty
        if ( empty_count == total_count ) {
        	$( target_tab ).removeClass('partial complete');
        	$( target_tab ).addClass('empty')
        }


        // Partial
        else if ( empty_count > 0 && empty_count < total_count ) {
        	$( target_tab ).removeClass('empty complete');
        	$( target_tab ).addClass('partial')
        }

        else {
        	$( target_tab ).removeClass('empty partial');
        	$( target_tab ).addClass('complete')
        }
        

        // console.log("check fields");
    }
    
    
    
    // Check All of the Fields
    function checkFieldsAll ( $target ) {
        
    }
    
    
    
    
    
    
//===================================================================================================
// Tab Wizard Generator
//===================================================================================================

    function generateTabs ( ) {
        var btn_lbl_next = $('.text-next').length ? $('.text-next').text() : "Next";
        var btn_lbl_back = $('.text-back').length ? $('.text-back').text() : "Back";
       $('.wizard').each(function ( mi ) {

            $_this = $(this);

            var ele_li = "";
            $('> h2.title', this).each( function (i) {
                _class  = $(this).attr('class');
                _id = $(this).attr('id');
                ele_li += "<li class='" + _class + "' id='" + _id + "'><a href='#tab-" + mi + "-" +i +"' class='tab-link'>" + $(this).text() + "</a></li>";
                $(this).remove();
            })


            // Add ID to table and wrap
            $('> table', this).each( function (i) {
                
                // Text Validation Loop at time of creation
                addValidator ( $('input[type="text"]', this) );
                
                $(this).wrap("<div class='tab-parent'>").parent().attr('id', "tab-" +  mi + "-" + i );



            })
            

            var _tabs = "<div class='tabs'><ul>" + ele_li + "</ul></div>";
            var _next_btn = "<div class='btn-control'><a href='#' class='btn prev'>" + btn_lbl_back + "</a><a href='#' class='btn next'>" + btn_lbl_next + "</a></div>";

            
            // wrapp all into master div
            $('.tab-parent').wrapAll('<div class="tab-container"></div>');

           
           // append and prepend 
            $(_tabs).prependTo($_this);
            $(_next_btn).insertAfter($('.tab-container'));



           //--------------------------------------------------
           // Check default Tab if Active Exists
           if( $.trim( $('#active-tab-id').val() ) !="" ) {

                var tab_id = $('#active-tab-id').val();
                target_item =  $('.tabs li[id="'+ tab_id +'"]');
                target_item.addClass('active');

                var _target = target_item.find('a').attr('href');
                $('.tab-parent', $_this).hide();
                $(_target).show().addClass('active').show();

           }
           
           /*
           else if( $('.tabs ul .active').length ) {
               
               var _target = $('.tabs ul .active a', $_this ).attr('href');
               $('.tab-parent', $_this).hide();
               $(_target).show().addClass('active').show();
           
           
           } */ 
           else {
               
               $('.tabs ul li:first-child, .tab-parent:first-child', $_this).addClass('active').show();
                
           }
           

            $('.btn.prev').addClass('disabled');


        })

        // Add Validation Function 
        checkValidator ( $('.tab-parent input[type="text"]') );


       
        //-------------------------------------------------------
        // Bind clicker
        // Tab Link Click
        //-------------------------------------------------------

        $('.tab-link').on('click', function () {
           
            // cache which was first Tab prior click
            var prev_tab = "#" + $('.tab-parent.active').attr('id');
            
            var _parentContainer =  $(this).parents('.wizard')
            var _target = $(this).attr('href');

            // asign id
            $('#active-tab-id').val($(this).parent().attr('id'));

            _parentContainer.find('li').removeClass('active')
            $(this).parent().addClass('active');


            _parentContainer.find('.tab-parent').hide().removeClass('active').removeAttr('style');

            $(_target).show().addClass('active')

            //------------------------------------
            checkActiveTab( $('.tabs li.active') , $(prev_tab) );



            return false;
        })



        //-------------------------------------------------------
        //  NEXT PREVIOUS
        //-------------------------------------------------------
        $('.btn.next').click(function () {

            var next_item_tab = $('.tabs ul li.active').next('li');

            // Remove Class Disabled from previous button
            $('.btn.prev').removeClass('disabled');

             checkActiveTab( $('.tabs li.active') );

            // check if next tab exist then proceed NEXT
            if( next_item_tab.length && !$(this).hasClass('disabled') ) {
                $(next_item_tab).find('a').trigger('click');

                scrollToElement($('.tabs'), 1000 );

                //setTimeout( function () {
                 /*   if( $('.tabs ul li.active').next('li').length == 0 ) {
                        $('.btn.next').addClass('disabled')
                    } */
                //},50)
            }

            return false;
        })


        //-------------------------------------------------------
        // Previous Button
        //-------------------------------------------------------
        $('.btn.prev').click(function () {

            var prev_item_tab = $('.tabs ul li.active').prev('li');

            // Remove Class Disabled from previous button
            $('.btn.next').removeClass('disabled');

             checkActiveTab($('.tabs li.active'));

            // check if next tab exist then proceed NEXT
            if( prev_item_tab.length && !$(this).hasClass('disabled') ) {
                $(prev_item_tab).find('a').trigger('click');

                scrollToElement($('.tabs'),1000);

                //setTimeout( function () {
                 /*   if( $('.tabs ul li.active').next('li').length == 0 ) {
                        $('.btn.next').addClass('disabled')
                    } */
                //},50)
            }

            return false;
        }) // wizard tab ends


       


    //------------------------------------------------------------------------
    // WIZARD EndS
    //------------------------------------------------------------------------
    }
    
    
   
    

    

//===================================================================================================    
// Sticky Table    
//===================================================================================================
    
lim = 4
newTable = $('#table2')
$(newTable).parent().addClass('tbl-cont')

var tdWidth = [];

// // calculat master width
for ( l = 0; l<lim; l++) {
    tdWidth[l] = $('tr:first > :eq('+ l +')', newTable ).width(); 
}


$('tr', newTable).each(function (it) {
  var  _this_tr = $(this);
  var left = 0;
  

//   // loop horizontal
  for (i = 0; i <= (lim - 1); i++) {
  
    var _this = $('> :eq(' + i + ')', this );
    var t_width = _this.width();

    c_width = tdWidth[i];
    
    $('> :eq(' + i + ')', this).css({
      'width': c_width,
      'height': _this.height(),
      'left': left
    }).promise().done(function () {
      
      _this.addClass('head head-' + i);
       left += _this.outerWidth();
      //console.log(left)
    })
  }
  
  $('.tbl-cont').css({'padding-left':left - 2});

})





   // $('.col.reply:empty').hide();

    if($('._tabs').length > 0 ){
       $('.tabs').tabify({
            //animated:true
            //effect:'slide'
        });
    }



    $('.summary-diagram .col:odd').addClass("even");



    if($('#table2').length > 0 ) {
        
        $('[class^=spots]').parent('td').addClass('no-space');
    }

    

    
    
    // --------------------------------
    // ADD ACTIVE CLASSES
    // --------------------------------

    // Sidebar Module-----------------------
        var windowPath = window.location.pathname
        var moduleActive = windowPath.split("/").filter(Boolean);

        $('.module-list li a[href$="'+ moduleActive[0] +'"]').parent().addClass('active')


    // Module --------------------------------
        if ($('.col.task-tab')) {

           $('.col.task-tab').find('.active').removeClass('active');
           $('.col.task-tab li a[href$="'+ windowPath +'"]').parent().addClass('active')

        }

    // Module Active ends -------------------

    var db_height = $("#dataBody").height();
    var tb_height = $("#taskBar").height()

    db_height > tb_height ? $('#taskBar').css('height', db_height ) : $('#dataBody').css('height', tb_height );

    $('#dataBody div a:contains("Back to List")').addClass('go-back');

    
    
    
    
    
    
    
    //-----------------------------------
    // SEARCH FILTER / ADVANCE SEARCH
    //-----------------------------------
    $('.content-block').on('click','.adv-filter',function() {
        var _expander = $(this)

        if (_expander.hasClass('expander')) {

            $(this).next('.filter').slideDown('fast', function() {
                _expander.addClass('close').removeClass('expander');
            })

        } else {
            $(this).next('.filter').slideUp('fast', function() {
                _expander.addClass('expander').removeClass('close');
            })
        }

    })



   
    
    
    
    
    //-----------------------------------
    // TASKBAR , ANIMATION
    //-----------------------------------

    var _triggerBind = $("#taskBar .module-list li").length

    $("#taskBar .module-list li").each(function(i, j) {
        //console.clear();
        // var _spanText = $('span', this).text();
        // var _spanLink = $('a', this).attr('href');
        // $('a', this).before($("<div class='mod-tooltip'><a href='" + _spanLink + "'>" + _spanText + "</a></div>"));
   
    })



    $('#taskBar .module-list li').hover( function() {
       
       if($(this).parents('.collapsed').length > 0 ) {
            var _spanText = $('span', this).text();
            var _spanLink = $('a', this).attr('href');
            $('a', this).before($("<div class='mod-tooltip'><a href='" + _spanLink + "'>" + _spanText + "</a></div>"));     
        
            $('.mod-tooltip',this).animate({
                'left': -20
            },250)

       }


        }, function() {
          $('.mod-tooltip',this).animate({
               'left': -220,
               opacity:0
            },
            {
                duration: 150,
                complete:function() {$(this).remove()
                    }
            })
    })

    // TASKBAR , ANIMATION ENDS ---------    






    // ----------------------------------
    // EXPANDERS AND COLLAPSERSS
    //-----------------------------------
    // Horizontal shift - style A -REJECTED

    if ($('.col-4 .expand-ctrl-box.hz').length > 0) {
        $('.col-4 .expand-ctrl-box.hz  span').click(function() {
            var _this = $(this);
            if ($(this).parent().prev('div').is(':visible')) {

                // slide up and make left side larger
                _this.parent().prev('div').slideUp('fast', function() {

                    $('.col-8.activity-log > div').delay(100).animate({
                        'width': '152%'
                    }, 500);
                    $('.col-4 .heading').animate({
                        'margin-bottom': 0
                    }, 500);
                    _this.addClass('close');

                });


            } else {
                $('.col-8.activity-log > div').delay(100).animate({
                    'width': '100%'
                }, {
                    duration: 500,
                    complete: function() {
                        $('.col-4 .heading').animate({
                            'margin-bottom': 20
                        }, 500)
                        _this.parent().prev('div').slideDown();
                        _this.removeClass('close');
                    } // complete

                }) // animate;
            }

        })
    }




    // sidebar module expander
    $('#taskBar .expand-ctrl-box.hz span').click(function() {
        var _this = $(this);
        if ($('.module-list ul.secondary').is(":visible")) {

            $('.module-list ul.secondary').slideUp('normal', function() {
                _this.rotate(180)
            })
        } else {
            $('.module-list ul.secondary').slideDown('normal', function() {
                _this.rotate(0)
            })
        }

    });


    $('.col-8.activity-log h3.heading').click(function() {
        $(this).toggleClass('closed').next('ul').slideToggle('fast');
    });


    //-----------------------------
    // taskbar collapser
    $('.expand-ctrl-box.taskbar span').click(function() {

        var _width;
        $(window).width() <= 1024 ? _width = 182 : _width = 220;

        var _this = $(this);


        if ($('#dataBody').hasClass('wide')) {
            $('#dataBody').animate({
                'margin-left': _width
            }, {
                duration: 150,
                complete: function() {

                    $('.module-list ul li a span').fadeIn('normal');
                    _this.rotate(0);
                    $('#dataBody').removeClass('wide');
                    $('.module-list').removeClass('collapsed')
                }
            }) // anim
            $('#taskBar').animate({
                'width': _width - 2
            }, 100);

        } else {

            $('.module-list ul li a span').fadeOut();
            $('#taskBar').animate({
                'width': 59
            }, 100) //anim;
            $('#dataBody').animate({
                'margin-left': 60
            }, 100).addClass('wide');
            _this.rotate(180);
            $('.module-list').addClass('collapsed');

        }

    })


    //-----------------------------
    // Summary page collapser

    $('.col-8.activity-log span.expand-ctrl').click(function() {
        var _this = $(this);
        var colWidth = 65.83333;
        // 65.83333% , 31.66667%;

        if ($('.col-4.summary-box').is(':visible')) {
            $('.col-4.summary-box').fadeOut('fast', function() {

                $('.col-8.activity-log').animate({
                    'width': '100%'
                }, {
                    duration: 500,
                    queue: true,
                    complete: function() {
                        setTimeout(function() {
                            _this.rotate(180)
                        }, 100);
                    }
                }); //anim


            });
        } else {
            $('.col-8.activity-log').animate({
                    'width': colWidth + '%'
                }, {
                    duration: 500,
                    complete: function() {
                        $('.col-4.summary-box').fadeIn('fast');
                        _this.rotate(0);
                    }
                } // complete
            ) // animate;
        }

    })


    // generic expanders
    $('.expander, .col-8.activity-log h3.heading').click(function() {
        if ($(this).next('.expandable').is(":visible")) {
            $(this).addClass('closed').next('.expandable').slideUp();

        } else {
            $(this).removeClass('closed').next('.expandable').slideDown();
        }
    })


   




    // -------- EXPANDABLES ENDS


    // CLean up 
    //$( '.contentDiv .row.no-margin' ).html( $.trim() );


    $('table.scrollable').wrap('<div class="scrolling-table"></div>');


    // -------------------------------------------

    // ----- POP UP -------------------------
    $('a[rel="ss-popup"]').click(function() {

        $('.ss-pop-container').show();
        return false;
    })

    $('.ss-pop-container .btn-close').click(function() {
        $('.ss-pop-container').hide()
    });








    /* ================================
    /* Temp Cleaner 
    =================================== */
    $('h4.heading').click(function() {
        $(this).next('.block').slideToggle()
    })


    $('fieldset legend').click(function() {
        $(this).parent('fieldset').children().not('legend').slideToggle('slow');
    })

    $(".homePage p").each(function() {
        var $this = $(this);
        $this.html($this.html().replace(/&nbsp;/g, ''));
    });

    $('p:empty').remove();

    /////     Temp Cleaner   //////////






    /*========  FAQ Post  ===========*/
    $(".faq-post").click(function(e) {

        if ($(this).parent().next("div.meta").is(":hidden")) {

            $(this).parent().addClass("expanded");
            $(this).parent().next("div.meta").slideDown();

        } else {
            $(this).parent().removeClass("expanded");
            $(this).parent().next("div.meta").slideUp();
        }

        e.preventDefault();

    });




    /*  *---Div Grid Table Formating */
    $(".contentTable tr:even, .content-table tr:even").addClass('altRow');

    // -------------------------------------
    /*  ======== WATERMARK ========*/
    // -------------------------------------
    //wtrmrk

    if ($('.wtmark').length > 0) {



        $('.wtmark').each(function() {
            $(this).addClass('nullText');
            $(this).val($(this).parent().find('label').text())
        })


        $('.wtmark').focus(function() {

            if ($(this).hasClass('nullText')) {
                $(this).val("");
                $(this).removeClass('nullText');
            }

        });

        $('.wtmark').blur(function() {
            tmpTxt = $(this).val()
            wtval = tmpTxt.replace(/^\s*/gm, '');

            if (wtval === "") {
                $(this).addClass('nullText')
                $(this).val($(this).parent().find('label').text())
            }
        })

    }



    $(".searchCont .submit").click(function() {

    })





    //====================================
    //  NAVIGATION MENU
    //====================================

    /* ======= VERTICAL MENU FIX =============*/
    $('.main-menu > ul > li:last').addClass('last-item');
    $('.main-menu > ul > li:first').addClass('first-item');

    $('.main-menu ul.sub ul').addClass('last-tier')

    // Control ---------------------

    $('.css-menu').removeClass('css-menu')

    $('.main-menu li ul').each(function() {
        $(this).parents('li').find('> a').addClass('arrow')
    })


    /* ======= MENU Hover if Not Phone =============*/



    $('a[href="#g"]').click(function() {
       
        return false;
    })

    //---------------------------------------





    //-----------------------------------
    // TOOLTIP FOR GRID ICONS
    //-----------------------------------

    $('.__td [class|="grid"]').hoverIntent({

        over: function() {
           
            var _top = $(this).offset().top;
            var _left = $(this).offset().left;
            var _text = $(this).attr('class').replace("grid-", "");

            $("<div class='grid-tooltip'>" + _text + "</div>").appendTo($('body')).stop().showMe(250, 10)
            $('.grid-tooltip').css({

                'left': _left - 15,
                'top': _top + 25
            })

        },

        out: function() {
            $('.grid-tooltip').fadeOut().remove();
            //console.log('I ma OUT')
        },

        timeout: 500,
        interval: 200,
        sensitivity: 4

    });



    $('td [class|="grid"]').hover(

        function() {
           
            var _top = $(this).offset().top;
            var _left = $(this).offset().left;
            var _text = "";
            var attr = $(this).attr('title');
            if (typeof attr !== typeof undefined && attr !== false) {
                _text = attr;
            } else {
                _text = $(this).attr('class').replace("grid-", "");
            }


            $("<div class='grid-tooltip'>" + _text + "</div>").appendTo($('body')).stop().fadeIn()
            //.showMe(250, 70)
            $('.grid-tooltip').css({

                'left': _left - 15,
                'top': _top + 25
            })

        },

        function() {
            $('.grid-tooltip').fadeOut().remove();
            //console.log('I ma OUT')
        }

        
    );




    // ==================================
    //     body resize
    //===================================

    function bodyResize() {
        var sidebarHeight = $('#sideBar').height();
        var bodyHeight = $('.contentDiv').height();
        if (sidebarHeight > bodyHeight) {
            $('.contentDiv').height(sidebarHeight - 20);
        }
    }

    /*------------------------------------------------*/



    /*======== JQUERY EASING ADD ON =============*/
    jQuery.extend(jQuery.easing, {
        def: 'easeOutQuad',
        swing: function(x, t, b, c, d) {
            //alert(jQuery.easing.default);
            return jQuery.easing[jQuery.easing.def](x, t, b, c, d);
        },
        easeInQuad: function(x, t, b, c, d) {
            return c * (t /= d) * t + b;
        },
        easeOutQuad: function(x, t, b, c, d) {
            return -c * (t /= d) * (t - 2) + b;
        },
        easeInElastic: function(x, t, b, c, d) {
            var s = 1.70158;
            var p = 0;
            var a = c;
            if (t == 0) return b;
            if ((t /= d) == 1) return b + c;
            if (!p) p = d * .3;
            if (a < Math.abs(c)) {
                a = c;
                var s = p / 4;
            } else var s = p / (2 * Math.PI) * Math.asin(c / a);
            return -(a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
        },
        easeOutBounce: function(x, t, b, c, d) {
            if ((t /= d) < (1 / 2.75)) {
                return c * (7.5625 * t * t) + b;
            } else if (t < (2 / 2.75)) {
                return c * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b;
            } else if (t < (2.5 / 2.75)) {
                return c * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b;
            } else {
                return c * (7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b;
            }
        },

        easeInBounce: function(x, t, b, c, d) {
            return c - jQuery.easing.easeOutBounce(x, d - t, 0, c, d) + b;
        }

    });




    
    //==================================================================================================
    // Scroll to element
    //==================================================================================================
    // var bodyElem;
    // if (jQuery.browser.webkit) bodyElem = jQuery("body");
    // else bodyElem = jQuery("html");

    function scrollToElement (Elem, speed, offset, callback) {

        offset = offset || 0;
        speed = speed || 500;

        jQuery( 'html , body' ).animate( {
            scrollTop : jQuery( Elem ).offset().top + offset
        }, {
            duration : speed,
            easing : globalEasing,
            queue : true,

            complete : function () {
                if ( jQuery.isFunction( callback ) ) {
                    callback();
                }
            }

        });

    };





    // Mobile testing function with nested function, will return boolean

    function deviceType() {

        this.android = function() {
            // console.log('android');
            return navigator.userAgent.match(/Android/i);
        }

        this.tablet = function() {
            // console.log('tab');
            return navigator.userAgent.match(/iPad/i);
        }

        this.phone = function() {
            // console.log('phone');
            return navigator.userAgent.match(/iPhone|Android|iPod|IEMobile/i);
        }


    };


    // var dd = new deviceType();
    // if( ! dd.phone ()  ) {
    //     console.log( "fd dfdfd dfdf dfdf dfd");
    // }
    // else { console.log(" I am on hone ok")

    // }

}); //Jquery




// sepia plugin 
( function($) {



    //-------------------------------------
    // -- Custom Animted show 
    //-------------------------------------

    jQuery.fn.showMe = function(speed, offset, callback) {
        var durSpeed = speed || 250;
        var offset = offset || 70;
        $(this).css({
            'margin-top': offset,
            'opacity': 0
        }).show();

        $(this).animate({

            'margin-top': 0,
            'opacity': 1

        }, {
            duration: durSpeed,
            queue: false
        })

    };

}(jQuery));

// sepia plugin 
( function($) {



    



    //----------------------------------------------
    // Tabs

    jQuery.fn.tabify = function(options) {

        // settings going to be , 
        //  align: top left right bottom
        //  effect : slide, fade, static
        //  animated height :true
        //  speed : 

        var settings = $.extend({

            align: "top",
            animated: false,
            speed: 'normal',
            easing: "swing",
            effect: 'static'

        }, options)

        
        // function begins
        this.each(function() {

            var master = this;

            $('> ul', this).wrapAll("<div class='tab-links'></div>");
            $('> div.tab-content', this).wrapAll("<div class='tab-container'></div>");


            $('.tab-links li:first').addClass('active');
            $('div.tab-container > .tab-content').not(':first').hide()


            // Click Handler for TAB
            $('div.tab-links .tab-link').on('click', function(e) {

                // setup id 
                var target = "#" + $(this).attr('rel');
                var targetParent = $(target).parent()
                


                // if ( $(this).parent().hasClass('active')) {
                //     return false;
                // }
                
                if ( $(target).is(":visible") ) { return false }
                
                if( $(this).is('a') ) {
                   e.preventDefault()
                }

                $('div.tab-links li').removeClass('active')
                // e.preventDefault();
               

                $(this).parent().addClass('active');
                $('input[type="radio"]', this).prop('checked',true).trigger('change')

                // apply style of height static or animated
                switch (settings.animated) {

                    case true:

                        var newHeight = $(target).getSize().height;

                        $('.tab-content').hide();

                        // animate container Height
                        $(targetParent).animate({
                            'height': newHeight
                        }, {

                            duration: settings.speed,
                            easing: settings.animation,
                            complete: function() {

                            }

                        }) // animate

                        // show in animated way
                        if (settings.effect == "slide") {

                            $(target).addClass('to-show').show();

                            $(target).animate({
                                'left': 0
                            }, {

                                duration: settings.speed,
                                easing: settings.animation,
                                complete: function() {
                                    $(target).removeClass('to-show').removeAttr('style');
                                }

                            }) // animate

                        } // slide
                        else {

                            $(target).show();
                        }
                        
                        //return false

                        break


                    case false:

                        $('.tab-content').hide();
                        $(target).show();

                        break;

                } // switch

            })



        })

        return this;
    }



    //-------------------------------------------------
    // -- ARRAY CLEANER IF ().FILTER NOT APPLIED
    //-------------------------------------------------
        // VAR arr = ["", ac , ada fa ]
        // arr.filter(Boolean)

        if (!Array.prototype.filter) {
          Array.prototype.filter = function (fn, context) {
            var i,
                value,
                result = [],
                length;
                if (!this || typeof fn !== 'function' || (fn instanceof RegExp)) {
                  throw new TypeError();
                }
                length = this.length;
                for (i = 0; i < length; i++) {
                  if (this.hasOwnProperty(i)) {
                    value = this[i];
                    if (fn.call(context, value, i, this)) {
                      result.push(value);
                    }
                  }
                }
            return result;
          };
        }

    //-----------------------------------------------------    


    //-------------------------------------
    // -- ROTATE ELEMENT
    //-------------------------------------

    $.fn.rotate = function(degrees) {
        $(this).css({
            '-webkit-transform': 'rotate(' + degrees + 'deg)',
            '-moz-transform': 'rotate(' + degrees + 'deg)',
            '-ms-transform': 'rotate(' + degrees + 'deg)',
            'transform': 'rotate(' + degrees + 'deg)'
        });
    };


    

    //----------------------------------------------
    // Dimention Calculator for hidden elements

    $.fn.getSize = function(mode) {

        //mode =  mode || 'actual';

        var $wrap = $("<div />").appendTo($("body"));
        $wrap.css({
            "position": "absolute !important",
            "visibility": "hidden !important",
            "display": "block !important"
        });

        $clone = $(this).clone().appendTo($wrap);


        if (mode !== "actual") {

            sizes = {
                "width": this.outerWidth(),
                "height": this.outerHeight()
            };
        } else {
            sizes = {
                "width": this.width(),
                "height": this.height()
            };
        }

        $wrap.remove();

        return sizes;
    };


}(jQuery));


/*!
 * hoverIntent r7 // 2013.03.11 // jQuery 1.9.1+
 * http://cherne.net/brian/resources/jquery.hoverIntent.html
 *
 * You may use hoverIntent under the terms of the MIT license.
 * Copyright 2007, 2013 Brian Cherne
 */
(function(e) {
    e.fn.hoverIntent = function(t, n, r) {
        var i = {
            interval: 100,
            sensitivity: 7,
            timeout: 200
        };
        if (typeof t === "object") {
            i = e.extend(i, t)
        } else if (e.isFunction(n)) {
            i = e.extend(i, {
                over: t,
                out: n,
                selector: r
            })
        } else {
            i = e.extend(i, {
                over: t,
                out: t,
                selector: n
            })
        }
        var s, o, u, a;
        var f = function(e) {
            s = e.pageX;
            o = e.pageY
        };
        var l = function(t, n) {
            n.hoverIntent_t = clearTimeout(n.hoverIntent_t);
            if (Math.abs(u - s) + Math.abs(a - o) < i.sensitivity) {
                e(n).off("mousemove.hoverIntent", f);
                n.hoverIntent_s = 1;
                return i.over.apply(n, [t])
            } else {
                u = s;
                a = o;
                n.hoverIntent_t = setTimeout(function() {
                    l(t, n)
                }, i.interval)
            }
        };
        var c = function(e, t) {
            t.hoverIntent_t = clearTimeout(t.hoverIntent_t);
            t.hoverIntent_s = 0;
            return i.out.apply(t, [e])
        };
        var h = function(t) {
            var n = jQuery.extend({}, t);
            var r = this;
            if (r.hoverIntent_t) {
                r.hoverIntent_t = clearTimeout(r.hoverIntent_t)
            }
            if (t.type == "mouseenter") {
                u = n.pageX;
                a = n.pageY;
                e(r).on("mousemove.hoverIntent", f);
                if (r.hoverIntent_s != 1) {
                    r.hoverIntent_t = setTimeout(function() {
                        l(n, r)
                    }, i.interval)
                }
            } else {
                e(r).off("mousemove.hoverIntent", f);
                if (r.hoverIntent_s == 1) {
                    r.hoverIntent_t = setTimeout(function() {
                        c(n, r)
                    }, i.timeout)
                }
            }
        };
        return this.on({
            "mouseenter.hoverIntent": h,
            "mouseleave.hoverIntent": h
        }, i.selector)
    }
})(jQuery)
