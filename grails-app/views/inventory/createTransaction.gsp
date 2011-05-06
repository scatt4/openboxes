<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        <g:set var="entityName" value="${message(code: 'transaction.label', default: 'Transaction')}" />
        <title>
	        <g:if test="${transactionInstance?.id }">
		        <g:message code="default.edit.label" args="[entityName]" />  
	    	</g:if>
	    	<g:else>
		        <g:message code="default.create.label" args="[entityName]" />    
			</g:else>    	    
		</title>
        <style>
        	.dialog form label { position: absolute; display: inline; width: 140px; text-align: right;}
        	.dialog form .value { margin-left: 160px; }
        	.dialog form ul li { padding: 10px; } 
        	.dialog form { width: 100%; } 
        	.header th { background-color: #525D76; color: white; } 
        </style>
        

		

    </head>    

    <body>
        <div class="body">

            <g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
            </g:if>						
            <g:hasErrors bean="${transactionInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${transactionInstance}" as="list" />
	            </div>
            </g:hasErrors>    

			<div class="dialog" >
			
				<!-- Action menu -->
				<div>
					<span class="action-menu">
						<button class="action-btn">
							<img src="${resource(dir: 'images/icons/silk', file: 'cog.png')}" style="vertical-align: middle;"/>
							<img src="${resource(dir: 'images/icons/silk', file: 'bullet_arrow_down.png')}" style="vertical-align: middle;"/>
						</button>
						<div class="actions">
							<g:if test="${params?.product?.id }">
								<div class="action-menu-item">
									<g:link controller="inventoryItem" action="showStockCard" params="['product.id':params?.product?.id]">
										<img src="${createLinkTo(dir: 'images/icons/silk', file: 'arrow_left.png')}"/>
										${message(code: 'default.button.cancel.label', default: 'Back to stock card')}
									</g:link>		
								</div>	
							</g:if>
							<div class="action-menu-item">
								<g:link controller="inventory" action="browse">
									<img src="${createLinkTo(dir: 'images/icons/silk', file: 'arrow_up.png')}"/>
									${message(code: 'default.button.cancel.label', default: 'Back to inventory')}
								</g:link>			
							</div>							

							<div class="action-menu-item">
								<g:link controller="inventory" action="listTransactions">
									<img src="${createLinkTo(dir: 'images/icons/silk', file: 'arrow_up.png')}"/>
									${message(code: 'default.button.cancel.label', default: 'Back to transactions')}
								</g:link>			
							</div>
						</div>
					</span>				
				</div>			
				<table style="height: 100%;">
					<tr>
						<td>							
							<div class="left" >
								<g:form action="saveNewTransaction">
								
									<fieldset>
										
										<g:hiddenField name="id" value="${transactionInstance?.id}"/>
										<table class="striped">
											<tr class="prop">
												<td>
													<label>Transaction ID</label>
												</td>
												<td>
													<span class="value">
														<g:if test="${transactionInstance?.id }">
															${transactionInstance?.id }
														</g:if>
														<g:else><span class="fade">(new transaction)</span></g:else>
													</span>
												</td>
											</tr>										
											<tr class="prop">
												<td>
													<label>Inventory</label>
												</td>
												<td>
													<span class="value">
														<g:hiddenField name="inventory.id" value="${warehouseInstance?.inventory?.id}"/>
														${warehouseInstance?.name }
													</span>								
												</td>
											</tr>
											<tr class="prop">
												<td>
													<label>Transaction Type</label>
												</td>
												<td>
													<span class="value">
														<g:select name="transactionType.id" from="${transactionTypeList}" 
								                       		optionKey="id" optionValue="name" value="${transactionInstance.transactionType?.id}" noSelection="['null': '']" />
							                       	</span>
												</td>
											</tr>
											<tr class="prop">
												<td>
													<label>Transaction Date</label>
												</td>
												<td>
													<span class="value">
														<g:jqueryDatePicker id="transactionDate" name="transactionDate"
																value="${transactionInstance?.transactionDate}" format="MM/dd/yyyy"/>
													</span>								
												</td>
											</tr>
											<tr>
												<td>
													<label>From</label>
												</td>
												<td>
													<span class="value">
														<g:select id="source.id" name="source.id" from="${locationInstanceList}" 
								                       		optionKey="id" optionValue="name" value="${transactionInstance?.source?.id}" noSelection="['null': '']" />
						                       		</span>
												</td>
											</tr>
											<tr>
												<td>
													<label>To</label>
												</td>
												<td>
													<span class="value">
														<g:select id="destination.id" name="destination.id" from="${locationInstanceList}" 
								                       		optionKey="id" optionValue="name" value="${transactionInstance?.destination?.id}" noSelection="['null': '']" />
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<label># Entries</label>
												</td>
												<td>
													<span class="value">
														${transactionInstance?.transactionEntries?.size() } &nbsp;
													</span>
												</td>
											</tr>
										</table>
									</fieldset>
									<fieldset>
										<div>
											<table id="transaction-entries-table" border="0" style="margin: 0; padding: 0; border: 0px solid lightgrey; background-color: white;">
												<thead>
													<tr class="odd">
														<th></th>
														<th style="width: 60%">Product</th>
														<th nowrap="true">Lot / Serial Number</th>
														<th nowrap="true">Expires</th>
														<th>Qty</th>
														<th>Actions</th>
													</tr>
												</thead>
												
												<tbody>
													<tr class="empty">
														<td colspan="6" style="text-align: center">
															<span class="fade">There are currently no items. Use the product search to the right to find items.</span>
														
														</td>
													</tr>
													<!--  dynamically populated -->
												</tbody>
											</table>
										</div>							
									</fieldset>
									
									<fieldset>
										<div style="text-align: center; padding: 10px;" class="odd">
											<button type="submit" name="save">								
												<img src="${createLinkTo(dir: 'images/icons/silk', file: 'tick.png')}"/>&nbsp;Save&nbsp;
											</button>
											
											<%-- 
											&nbsp;
											<button name="clear" class="clear">								
												<img src="${createLinkTo(dir: 'images/icons/silk', file: 'cross.png')}"/>&nbsp;Clear&nbsp;
											</button>
											--%>
											<g:if test="${transactionInstance?.id }">
												&nbsp;
												<button name="_action_deleteTransaction" id="${transactionInstance?.id }" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
							    					<img src="${createLinkTo(dir:'images/icons/silk',file:'bin.png')}" alt="Delete" />
													&nbsp;${message(code: 'default.button.delete.label', default: 'Delete')}&nbsp;
												</button>							
											</g:if>
										</div>		
									</fieldset>		
								</g:form>
							</div>
						</td>
						
						<td style="border: 1px solid lightgrey; width: 25%; padding: 0px; margin: 0; height: 100%; background-color: #f7f7f7;">
							
							<h3 style="padding: 10px;">Add an item</h3>
							<input type="hidden" id="hiddenProductId" value=""/>
							<input type="hidden" id="hiddenProductName" value=""/>
							<div style="padding: 10px;">
								<g:textField  id="productSearch" name="productSearch" value="Search for a product ..." size="25"/> 										
							</div>				
							<div id="product-details">
								<table>
									<tr class="prop">
										<td><b>Description</b></td>
										<td><span id="product-details-name"></span></td>
									</tr>
									<tr class="prop">
										<td><b>Manufacturer</b></td>
										<td><span id="product-details-manufacturer"></span></td>
									</tr>
									<tr class="prop">
										<td colspan="2" style="padding: 0; margin: 0;">
											<table id="product-details-lotNumbers">
												<thead>
													<tr class="odd">
														<th></th>
														<th>Item</th>
														<th>Expires</th>
														<th>Qty</th>
														<th></th>
													</tr>
												</thead>
												<tbody>
												</tbody>														
											</table>
										</td>
									</tr>
								</table>									
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>


        <script>
			/**
			 * FIXME Mixing javascript and GSP logic is a terrible idea!!!
			 * Initialize the transaction entry array
			 */
	        var transaction = { TransactionEntries: [] };
	        <g:if test="${transactionInstance?.transactionEntries }">
	        	<g:set var="index" value="${0 }"/>
		        <g:set var="transactionMap" value="${transactionInstance?.transactionEntries?.groupBy { it?.inventoryItem?.product?.name } }"/>
				<g:each in="${transactionMap?.keySet()}" var="key" >
					<g:set var="transactionEntries" value="${transactionMap?.get(key) }"/>
					<g:each in="${transactionEntries }" var="transactionEntry" status="status">	        
						var entry = { 
							Id: '${transactionEntry?.id}', 
							Index: ${index++}, 
							Template: '${(transactionEntry?.inventoryItem?.id)?"#existing-item-template":"#new-item-template"}', 
							ProductId: '${transactionEntry?.inventoryItem?.product?.id}', 
							ProductName: '${transactionEntry?.inventoryItem?.product?.name}', 
							InventoryItemId: '${transactionEntry?.inventoryItem?.id}', 
							LotNumber: '${transactionEntry?.inventoryItem?.lotNumber}', 
							Qty: '${transactionEntry?.quantity}', 
							ExpirationMonth: '<g:formatDate date="${transactionEntry?.inventoryItem?.expirationDate}" format="M"/>', 
							ExpirationYear: '<g:formatDate date="${transactionEntry?.inventoryItem?.expirationDate}" format="yyyy"/>',
							ExpirationDate: '<g:formatDate date="${transactionEntry?.inventoryItem?.expirationDate}" format="MMM yyyy"/>'
						};
						
						transaction.TransactionEntries.push(entry);
					</g:each>
				</g:each>
			</g:if>
		</script>
		<script>

			function selectCombo(comboBoxElem, value) {
				if (comboBoxElem != null) {
					if (comboBoxElem.options) { 
						for (var i = 0; i < comboBoxElem.options.length; i++) {
				        	if (comboBoxElem.options[i].value == value &&
				                comboBoxElem.options[i].value != "") { //empty string is for "noSelection handling as "" == 0 in js
				                comboBoxElem.options[i].selected = true;
				                break
				        	}
						}
					}
				}
			}		
		
			function paintStripes(obj) { 
            	obj.not(":hidden").removeClass("even");
            	obj.not(":hidden").removeClass("odd");            	
				obj.not(":hidden").filter(":even").addClass("even");
				obj.not(":hidden").filter(":odd").addClass("odd");
            }
            
			function changeTransactionType(select) { 
				var transactionType = select.val();
				//option:selected
				if (transactionType == ${org.pih.warehouse.core.Constants.TRANSFER_IN_TRANSACTION_TYPE_ID}) {
					$("#source\\.id").closest("tr").show();
					$("#destination\\.id").closest("tr").hide();
				}
				else if (transactionType == ${org.pih.warehouse.core.Constants.TRANSFER_OUT_TRANSACTION_TYPE_ID}) {
					$("#source\\.id").closest("tr").hide();
					$("#destination\\.id").closest("tr").show();
				}
				else {
					$("#source\\.id").closest("tr").hide();
					$("#destination\\.id").closest("tr").hide();
				}						
				//var stripedList = $(".striped li").not(":hidden");
								
				paintStripes($(".striped tr"));
				//$("#transaction-entries-li").addClass("even");
				
			}

			// If the transaction exists, remove it from the database
			function removeItem(index) { 
				var entry = transaction.TransactionEntries[index];
				console.log(entry.Id);
				if (entry.Id && entry.Id != 0) { 
					$.ajax({
						type: 'POST',
						url: '/warehouse/json/deleteTransactionEntry',
						data: 'id='+ entry.Id,
						cache: false,
						success: function(){
							transaction.TransactionEntries.splice(index, 1);
							renderTable();
						},
						error: function (request, status, error) {
							alert(request.responseText);
						}
					});					
				}
				// Only remove entry from page-scoped transaction since it's not in the database yet
				else { 
					transaction.TransactionEntries.splice(index, 1);
					renderTable();
				}
			}
			
			
			function addNewItem(productId) { 
				$.getJSON('/warehouse/json/findProduct', {id: productId}, function(data) {
    				var index = transaction.TransactionEntries.length;
	    			var entry = { Id: '0', Index: index, ProductId: data.product.id, Template: '#new-item-template', ProductName: data.product.name, LotNumber: '', ExpirationDate: '', ExpirationMonth: '', ExpirationYear: '', Qty: 0 };
					transaction.TransactionEntries.push(entry);	    			
					renderTable();
				}); 
			}

			

			function addExistingItem(productId, lotNumber) {
				//alert("add existing item with product: " + product + ", lotNumber: " + lotNumber); 
				$.getJSON('/warehouse/json/findInventoryItem', {productId: productId, lotNumber: lotNumber}, function(data) {
    				var index = transaction.TransactionEntries.length;
	    			var entry = { Id: '0', Index: index, ProductId: data.product.id, Template: '#existing-item-template', InventoryItemId: data.inventoryItem.id, ProductName: data.product.name, LotNumber: data.inventoryItem.lotNumber, ExpirationDate: data.inventoryItem.expirationDate, ExpirationMonth: '', ExpirationYear: '', Qty: 0 };
	    			// for some reason, the following "exists" check does not work
					//if (!$.inArray(entry, transaction.TransactionEntries)) { 	    			
						transaction.TransactionEntries.push(entry);	    			
					//}
					renderTable();
				}); 				
			}

			function format(o, t) {
				console.log("format date");
				console.log(typeof(o));
				console.log(typeof(t));
				//var date = parseDate(o);
				var date = $.datepicker.parseDate('yy-mm-dd', '2007-01-26');
			    return $.format(date, t);
			}

			/**
			 * Clear the given field
			 */
			function clear(field) { 
		    	field.removeClass("fade"); 
		    	field.val(''); 
			}					
			
			function renderTable() { 
				// Need to remove all existing rows before re-rendering table 
				$("#transaction-entries-table > tbody tr").remove();
				if (transaction.TransactionEntries.length > 0) { 
					//$("#transaction-entries-table > tbody tr.empty").hide();	
					$.each(transaction.TransactionEntries, function(index, value) { 
						value.Index = index;
						$(value.Template).tmpl(value).appendTo('#transaction-entries-table > tbody');	
					});

					// Select all months 
					var expirationMonths = $(":input[id^=expirationDate][id$=month]");
					$.each(expirationMonths, function(index, select) { 
						//var index = select.parent().prev().children(".index").val();
						var month = transaction.TransactionEntries[index].ExpirationMonth;
						selectCombo(select, month);
					});					

					// Select all years 
					var expirationYears = $(":input[id^=expirationDate][id$=year]");
					$.each(expirationYears, function(index, select) { 
						//var index = select.parent().prev().children(".index").val();
						var year = transaction.TransactionEntries[index].ExpirationYear;
						selectCombo(select, year);						
					});
					paintStripes($("#transaction-entries-table > tbody tr"));  
				} 			
			}			


					
		</script>

		<script>
	    	$(document).ready(function() {

/* ------------------------------	Initialization ------------------------------ */

	    		$('#product-details').hide();		    	

				// Initialize table with the transaction entries from the server 
		    	renderTable();

		    	// Initialize the transaction type selector
		    	changeTransactionType($("#transactionType\\.id"));
		    	
		    	// Initialize the product search autocomplete
				$('#productSearch').addClass("fade");
		    	
		    	
/* --------------------	Transaction Type Switcher Handler	----------------------- */
		    			    	
		    	/**
		    	 * On change of transaction type, initialize the fields 
		    	 * to display.
		    	 */
				$("#transactionType\\.id").change(function(){
					changeTransactionType($(this));					
				});
				
/* --------------------	Delete Item Handler	----------------------- */

	    		/**
	    		 * On click of delete-product button, remove entire product row.
	    		 */
	    		$(".delete-item").livequery(function(){
					$(this).click(function(event) {					
						removeItem($(this).val());
					});
			    });

/* --------------------	Lot Number Save Handler	----------------------- */

	    		/**
	    		 * On click of delete-product button, remove entire product row.
	    		 */
	    		$(".lotNumber").livequery(function(){
					$(this).change(function(event) {					
						var index = $(this).parent().children(".index").val();
						transaction.TransactionEntries[index].LotNumber = $(this).val();						
					});
			    });

/* --------------------	Expiration Date Save Handler	----------------------- */

	    		/**
	    		 * On click of delete-product button, remove entire product row.
	    		 */
				
	    		$(":input[id^=expirationDate][id$=month]").livequery(function(){
	    			//console.log("found a month");
					$(this).change(function(event) {
						var index = $(this).parent().prev().children(".index").val();
						var month = $(this).val();
						transaction.TransactionEntries[index].ExpirationMonth = month;
					});
			    });


	    		/**
	    		 * On click of delete-product button, remove entire product row.
	    		 */
	    		$(":input[id^=expirationDate][id$=year]").livequery(function(){
					$(this).change(function(event) {
						var index = $(this).parent().prev().children(".index").val();
						var year = $(this).val();
						transaction.TransactionEntries[index].ExpirationYear = year;
					});
			    });




/* --------------------	Quantity Save Handler	----------------------- */

	    		/**
	    		 * On click of delete-product button, remove entire product row.
	    		 */
	    		$(".quantity").livequery(function(){
					$(this).change(function(event) {					
						var index = $(this).parent().children(".index").val();
						transaction.TransactionEntries[index].Quantity = $(this).val();						
					});
			    });



/* --------------------	Product Search Handler	----------------------- */

				/**
				 * When product search becomes focus, we remove fade, reset values
				 */
		    	$('#productSearch').focus(function() { 
			    	clear($(this));
			    	//$("#product-details").hide();
					//$("#productId").val('');
					//$("#productName").val('');			    				    	
			    });

			    
		    	//$("#productSearch").blur(function() { 
				//	$(this).addClass("fade");
			    //	$(this).val('Find another product to add'); 
			    //});		    	


	    		/**
	    		 * Suppress the submit action when the ENTER key is pressed during a product search.
	    		 * In addition, we want to trigger a CLICK event on the addProduct button.
	    		 */
	    		$("#productSearch").keypress(function (event) {
	    			if (event.keyCode == 13) {
	    			    event.preventDefault();
	    			    //$("#addProduct").trigger("click");
	    			}
	    		});   		
	    		
	    		/**
	    		 * Bind autocomplete widget to the product search field.
	    		 */
	    		$('#productSearch').autocomplete( {
		    		//selectFirst: true,
					minLength: 2,
					delay: 100,
    				source: function(request, response) {
    					var currentWarehouseId = $("#currentWarehouseId").val();
    					$.getJSON('/warehouse/json/findProductByName', { term: request.term, warehouseId: currentWarehouseId }, function(data, status, xhr) {
    						var items = [];
    						$.each(data, function(i, item) { items.push(item); });
    						response(items);
    					});
    				},
    				focus: function( event, ui ) {
    					$(this).val( ui.item.label );	// in order to prevent ID from being displayed in widget
    					return false;
    				},
    				select: function(event, ui) {
    					$('#productSearch').blur();
    					
    					// in order to prevent ID from being displayed in widget
    					$(this).val( ui.item.label ); 	
        				
        				// Show product details
        				$('#product-details').show();
    		    		$("#hiddenProductId").val(ui.item.product.id);
        				$("#hiddenProductName").val(ui.item.product.name);
        				$("#product-details-id").html(ui.item.product.id);
    					$("#product-details-name").html(ui.item.product.name);
        				$("#product-details-manufacturer").html(ui.item.product.manufacturer);

    					// Reset product search
    					$('#productSearch').addClass("fade");					
    		    		$('#productSearch').val("Search products ...");    					

    		    		// Show product display DIV
						$('#product-details').slideDown("fast");
    		    		//$("#addProduct").focus();


    		    		// Clear table and add inventory items     		    		
    		    		$('#product-details-lotNumbers > tbody tr').remove();
    		    		
    		    		if (ui.item.inventoryItems) { 
        		    		$('#product-details-lotNumbers').show();
        		    		$.each(ui.item.inventoryItems, function(index, value) { 
	    		    			var lotNumber = value.lotNumber || "<span class='fade'>EMPTY</span>";
	    		    			console.log(typeof(value.expirationDate));
	    		    			var expirationDate = value.expirationDate;
	    		    				    		    			
	    		    			var existingLotNumber = 
		    		    			"<tr>" + 
		    		    			"<td><button onClick=\"addExistingItem('" + ui.item.product.id + "','" + value.lotNumber + "');\"><img src=\"${resource(dir: 'images/icons/silk', file: 'add.png')}\" style=\"vertical-align: middle;\"/></button></td>" + 
		    		    			"<td>" + lotNumber + "</td>" + 
	    		    				"<td>" + value.expirationDate + "</td>" + 
	    		    				"<td>" + value.quantity + "</td>" + 
	    		    				"<td></td>" + 
	    		    				"</tr>";
		    		    		
								$("#product-details-lotNumbers > tbody:last").append($(existingLotNumber));	        		    		
							});

    		    			var newLotNumber = 
	    		    			"<tr class=\"prop\">" + 
	    		    			"<td><button onClick=\"addNewItem('" + ui.item.product.id + "');\"><img src=\"${resource(dir: 'images/icons/silk', file: 'add.png')}\" style=\"vertical-align: middle;\"/></button></td>" + 
	    		    			"<td colspan=\"3\">Add a new lot/serial number?</td>" + 
    		    				"<td></td>" + 
    		    				"</tr>";
							$("#product-details-lotNumbers > tbody:first").append($(newLotNumber));	        		    		
	    		    		
							
    		    		}
    		    		else { 
        		    		$('#product-details-lotNumbers').hide();
        		    	}
    		    		
    					return false;
    				}
    				
	    		});


	    		/**
	    		 * Bind autocomplete widget to the all .lotNumber input fields.  
	    		 * The livequery feature allows us to bind the autocomplete 
	    		 * widget to all lot number fields (including those created after
	    	     * the onload event has completed.
	    		 */
	    		 /*
				$(".lotNumber").livequery(function() {
					// For some reason, we have to get the product ID outside of the autocomplete.
					var productId = $(this).parent().children(".productId").val();
					$(this).autocomplete( {
						delay: 100,
						minLength: 2,
	    				source: function(request, response) {	    				
	    					// Pass productId and search term to the server
	    					$.getJSON('/warehouse/json/findLotsByName', {term: request.term, productId: productId}, function(data) {
	    						var items = [];
	    						$.each(data, function(i, item) { items.push(item); });
	    						response(items);
	    					});
	    				},
	    				select: function(event, ui) {
		    				//$(this).parent().find('.lotNumber').val(ui.item.lotNumber);
		    				$(this).val(ui.item.lotNumber)
		    				return false;
		    				//$(this).parent().siblings().find()
	    				},
	    				focus: function(event, ui) { 
	    					$(this).val( ui.item.label );	// in order to prevent ID from being displayed in widget
	    					return false;		    				
		    			},
	    				change: function(event, ui) { 
							// Allows user to enter a new lot number value
							var value = $(this).attr('value');
							$(this).parent().find('.hiddenLotNumber').val(value);
							return false;
		    			}	    				
		    		});

		    		$(this).keypress(function (event) {
		    			if (event.keyCode == 13) {
		    			    event.preventDefault();
		    			}
		    		});   
				});
	    		*/	    		
		    	
	    	});
        </script>

        <script id="existing-item-template" type="x-jquery-tmpl">						
			<tr id="row-{{= Index }}">
				<td>
					<span class="fade">{{= Index }}</span>
				</td>
				<td>
					<!-- Product ID: {{= ProductId}} --> 
					
					{{= ProductName}} 
					
					<!-- Supported for backwards compatibility -->
					<g:hiddenField name="transactionEntries[{{= Index}}].product.id" value="{{= ProductId}}"/>
					<g:hiddenField name="transactionEntries[{{= Index}}].lotNumber" value="{{= LotNumber}}"/>
				</td>
				<td>
					<!-- Inventory Item ID: {{= InventoryItemId}} --> 
					
					{{= LotNumber}}
					<g:hiddenField class="index" name="index" value="{{= Index}}"/>
					<g:hiddenField class="lotNumber" name="transactionEntries[{{= Index}}].inventoryItem.lotNumber" size="15" value="{{= LotNumber}}"/>
					<g:hiddenField class="productId" name="transactionEntries[{{= Index}}].inventoryItem.product.id" value="{{= ProductId}}"/>
					<g:hiddenField class="inventoryItemId" name="transactionEntries[{{= Index}}].inventoryItem.id" value="{{= InventoryItemId}}"/>
				</td>
				<td nowrap="true">
				
					
					{{if ExpirationDate}}
						{{= ExpirationDate}}
					{{else}}
						never
					{{/if}}	
					
							
					<!-- Needed in order to keep the order of date field indexes in sync with transaction entry index (see renderTable() method). -->
					<input type="hidden" id="expirationDate[{{= Index}}]_month" name="transactionEntries[{{= Index}}].inventoryItem.expirationDate_month"/>
					<input type="hidden" id="expirationDate[{{= Index}}]_year" name="transactionEntries[{{= Index}}].inventoryItem.expirationDate_year"/>
				</td>
				<td>
					<g:textField class="quantity" name="transactionEntries[{{= Index}}].quantity" value="{{= Qty}}" size="3"/>
				</td>
				<td nowrap="nowrap">
					<g:hiddenField id="product.id" name="product.id" value="{{= ProductId}}"/>
					<g:hiddenField id="productName" name="productName" value="{{= ProductName}}"/>
					<button type="button" class="delete-item" value="{{= Index}}">
						<img src="${createLinkTo(dir: 'images/icons/silk', file: 'cross.png')}"/>
					</button>					
				</td>
			</tr>        
		</script>
		
        <script id="new-item-template" type="x-jquery-tmpl">						
			<tr id="row-{{= Index }}">
				<td>
					<span class="fade">{{= Index }}</span>
				</td>
				<td>
					<!-- Product ID: {{= ProductId}}  -->
					{{= ProductName}} 
					
					<!-- Supported for backwards compatibility -->
					<g:hiddenField name="transactionEntries[{{= Index}}].product.id" value="{{= ProductId}}"/>
					<g:hiddenField name="transactionEntries[{{= Index}}].lotNumber" value="{{= LotNumber}}"/>
					
				</td>
				<td>
					<!-- Inventory ID: {{= InventoryItemId}} -->
					<g:hiddenField class="index" name="index" value="{{= Index}}"/>
					<g:textField class="lotNumber" name="transactionEntries[{{= Index}}].inventoryItem.lotNumber" size="15" value="{{= LotNumber}}"/>
					<g:hiddenField class="productId" name="transactionEntries[{{= Index}}].inventoryItem.product.id" value="{{= ProductId}}"/>
					<g:hiddenField class="inventoryItemId" name="transactionEntries[{{= Index}}].inventoryItem.id" value="{{= InventoryItemId}}"/>
				</td>
				<td nowrap="true">
					<g:datePicker id="expirationDate[{{= Index}}]" name="transactionEntries[{{= Index}}].inventoryItem.expirationDate" precision="month" default="none" noSelection="['':'']"
						years="${(1900 + (new Date().year))..(1900+ (new Date() + (50 * 365)).year)}"/>					
				</td>
				<td>
					<g:textField class="quantity" name="transactionEntries[{{= Index}}].quantity" value="{{= Qty}}" size="3"/>
				</td>
				<td nowrap="nowrap">
					<button type="button" class="delete-item" value="{{= Index}}">
						<img src="${createLinkTo(dir: 'images/icons/silk', file: 'cross.png')}"/>
					</button>					
				</td>
			</tr>        
		</script>        
        
       		
		
    </body>
</html>
