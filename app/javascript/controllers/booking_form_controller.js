import { Controller } from "stimulus";

export default class extends Controller {

    modalID = document.getElementById("authentication-modal")
    eventId = ""
    token = document.getElementsByName("csrf-token")[0].content
    notification = document.getElementById("notification")

  options = {
		placement: 'bottom-right',
		backdrop: 'static',
		backdropClasses: 'bg-red-900',
		closable: true,
	};



	modal = new Modal(this.modalID, this.options);

    connect() {
        this.element.click
    }



    showForm(event) {
        event.preventDefault();
        this.modal.show();
        this.eventId = event.target.dataset.event
        // console.log(event.currentTarget.href);
        // console.log(event.target.dataset.event)
    }

    async saveBooking() {
        const formData = new FormData();
        const quantity = document.getElementById("quantity").value;

        formData.append("booking[event_id]", this.eventId);
        formData.append("booking[ticket_quantity]", quantity); 

        try {

      
            const response = await fetch(`/events/${this.eventId}/bookings`, {
                method: 'POST',
                headers: { "X-CSRF-Token": this.token,  "Accept": "text/vnd.turbo-stream.html"},
                body: formData 
            });

        // const html = await response.text()
        // Turbo.renderStreamMessage(html)

            
        
            
            const data = await response.json();
            
            if (data) {
                const notification = "Booking created";
                localStorage.setItem('notification', notification);
                Turbo.visit("my_bookings");
            } else {
                console.log("Data is not available.");
            }
        } catch (error) {
            console.error('Error occurred:', error);
            this.notification.innerHTML = "An error occurred. Please try again.";
        }
    }


}