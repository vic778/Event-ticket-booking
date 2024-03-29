import { Controller } from "stimulus";

export default class extends Controller {

    modalID = document.getElementById("authentication-modal")
    eventId = ""
    token = document.getElementsByName("csrf-token")[0].content

  options = {
		placement: 'bottom-right',
		backdrop: 'static',
		backdropClasses: 'bg-red-900',
		closable: true,
	};



	modal = new Modal(this.modalID, this.options);

    connect() {
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

    const response = await fetch(`/events/${this.eventId}/bookings`, {
        method: 'POST',
        headers: { "X-CSRF-Token": this.token },
        body: formData 
    });

    console.log(response);
       if (response.ok) {
        window.location.href = "my_bookings"
        
    } else {
        console.log("response is not ok");
    }
}

}