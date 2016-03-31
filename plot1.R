##-------------------------------------------------------------------------------------------------------------
##	Creation Date 	: 30-Apr-2016
##	Created By 		: Vaishali Katkar
##	Purpose			: This script is created to view a graph (Bar Chart) named as "Global Active Power"
##					  which contains Frequency at 'Y' axis and Global Active Power in Kilowatts at 'X' axis
##
##	Variables 		: 
					# hpc_data = the table which contains data read from file "household_power_consumption.txt"
					# subsetdata = sub set of data for dates 2007-02-01 and 2007-02-02
					# Date: Date in format dd/mm/yyyy
					# Time: time in format hh:mm:ss
					# Global_active_power: household global minute-averaged active power (in kilowatt)
					# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
					# Voltage: minute-averaged voltage (in volt)
					# Global_intensity: household global minute-averaged current intensity (in ampere)
					# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
					# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
					# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

## Pre-Requisite 	: Keep household_power_consumption.txt file at data folder.
##-------------------------------------------------------------------------------------------------------------

		## Set working directory
		setwd("G:/RWrokingDirectory") # Change the working directory path here
		
		## Check data file is present at working directory
		if(!file.exists("./data/exdata-data-household_power_consumption.zip")) {
				temp <- tempfile()
				download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
				file <- unzip(temp)
				unlink(temp)
		}	

		
		# read file household_power_consumption.txt in to a variable
		hpc_data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
		
		# Check the headers
		head(hpc_data)
		
		# convert character date to date format
		hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
		
		# Get data for dates 2007-02-01 and 2007-02-02 in a sub set
		subhpcdata <- hpc_data[(hpc_data$Date == "2007-02-01") | (hpc_data$Date == "2007-02-02"),]
		
		# Check the subhpcdata
		head(subhpcdata)
		
		# convert to numeric field Global_active_power
		subhpcdata$Global_active_power <- as.numeric(as.character(subhpcdata$Global_active_power))
		
		# convert to numeric field Global_reactive_power
		subhpcdata$Global_reactive_power <- as.numeric(as.character(subhpcdata$Global_reactive_power))
		
		# convert to numeric field Global_reactive_power
		subhpcdata$Voltage <- as.numeric(as.character(subhpcdata$Voltage))
		
		# Convert timestamp
		subhpcdata <- transform(subhpcdata, timestamp = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
		
		# convert to numeric field Sub_metering_1
		subhpcdata$Sub_metering_1 <- as.numeric(as.character(subhpcdata$Sub_metering_1))
		
		# convert to numeric field Sub_metering_2
		subhpcdata$Sub_metering_2 <- as.numeric(as.character(subhpcdata$Sub_metering_2))
		
		# convert to numeric field Sub_metering_3
		subhpcdata$Sub_metering_3 <- as.numeric(as.character(subhpcdata$Sub_metering_3))
		
		# Plot the graph
		hist(subhpcdata$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
		dev.copy(png, file="plot1.png", width=480, height=480)
		dev.off()
		
		#get folder where the plot1.png is saved
		cat("plot1.png has been saved in", getwd())
		
# --------------------  End of script  ---------------------------------------------------------------------------------------------------------		
		
		
		
		
		
		
		
		
		
		