rankhospital <- function(state, outcome, num = 'Best'){
        myfile <- list.files("./Hospital_compare", full.names =  TRUE)
        
        #Reading the data
        my_data <- read.csv("./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", 
                            na.strings = "Not Available",
                            stringsAsFactors = FALSE)
        #selecting data
        select_data <- as.data.frame(cbind(my_data[,2],my_data[,7],my_data[,11],
                                           my_data[,17],my_data[,23]))
        
        colnames(select_data) <- c("hospital", "state", "heart attack",
                                   "heart failure", "pneumonia")
        
        ## Check that state and outcome are valid
        if(!state %in% select_data[,"state"]){
                stop('invalid state')
        }
        if(!outcome %in% c("heart attack", "heart failure", "pneumonia")){
                stop('invalid outcome')
        }
        if( num != "best" && num != "worst" && num%%1 != 0 ){
                stop("invalid num")}
        #select state
        
        my_state <- select_data[(select_data[,"state"]== state),]
        my_state <- unique(my_state)
        #select interested columns which include hospital name, state and outcomes
        my_state <- my_state %>% 
                select(c("hospital",state,outcome))
        ##order the outcome
        my_state[, outcome] <- as.numeric(my_state[, outcome])
        lowest_num <- my_state[order(my_state[,outcome], my_state[,"hospital"],
                                     na.last = NA ),] 
        
        if(num =="best"){
                num <- 1
        }
        else if (num =="worst"){
                num <- nrow(lowest_num)
        }
        else{
                lowest_num[num,2]
        }
        #return the hospital name
        lowest_num[num,1]
        
}